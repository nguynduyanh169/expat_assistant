import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/wallet_cubit.dart';
import 'package:expat_assistant/src/models/payment_result.dart';
import 'package:expat_assistant/src/repositories/payment_repository.dart';
import 'package:expat_assistant/src/states/wallet_state.dart';
import 'package:expat_assistant/src/utils/payment_utils.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<PaymentView> paymentsHistory = [];
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          WalletCubit(PaymentRepository())..getPaymentsHistory(),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black38,
                height: 0.25,
              ),
              preferredSize: Size.fromHeight(0.25)),
          elevation: 0.5,
          backgroundColor: AppColors.MAIN_COLOR,
          automaticallyImplyLeading: true,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Payments History',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(RouteName.HOME_PAGE));
                },
                icon: Icon(CupertinoIcons.home)),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state.status.isLoadingWallet) {
              return LoadingView(message: 'Loading...');
            } else {
              if (state.status.isLoadWalletSuccess) {
                paymentsHistory = state.paymentLists;
              }
              return Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      child: Text(
                        'Payments amount on each months',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.MAIN_COLOR),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 2),
                      width: SizeConfig.blockSizeHorizontal * 95,
                      height: SizeConfig.blockSizeVertical * 23,
                      child: LineChart(mainData(paymentsHistory)),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
                            child: Text(
                              'Payment History',
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.MAIN_COLOR),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2),
                            child: Text(
                              'You have spent ${PaymentUtils.caculateTotalInYear(paymentsHistory)} VNĐ for this years',
                              style: GoogleFonts.lato(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2,
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 45,
                            child: ListView.separated(
                              itemCount: paymentsHistory.length,
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.black54,
                                height: 2,
                              ),
                              itemBuilder: (context, index) => ListTile(
                                leading: Icon(
                                  LineIcons.phoneVolume,
                                  color: AppColors.MAIN_COLOR,
                                ),
                                title: Text(
                                  'Consultant Fee',
                                  style: GoogleFonts.lato(),
                                ),
                                subtitle: Text(
                                  PaymentUtils.getDateTimeForPayment(startDateTime: paymentsHistory[index].createDate),
                                  style: GoogleFonts.lato(),
                                ),
                                trailing: Text(
                                  '- ${paymentsHistory[index].amount} VNĐ',
                                  style:
                                      GoogleFonts.lato(color: Colors.redAccent),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  LineChartData mainData(List<PaymentView> payments) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 13),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Feb';
              case 3:
                return 'Apr';
              case 5:
                return 'Jun';
              case 7:
                return 'Aug';
              case 9:
                return 'Oct';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '100';
              case 3:
                return '300';
              case 5:
                return '500';
            }
            return '';
          },
          reservedSize: 8,
          margin: 15,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: PaymentUtils.getNumberForChart(payments),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
