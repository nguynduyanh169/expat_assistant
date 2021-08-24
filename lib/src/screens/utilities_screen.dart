import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/services_cubit.dart';
import 'package:expat_assistant/src/repositories/payment_repository.dart';
import 'package:expat_assistant/src/states/services_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UtilitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String totalPrice = 'caculating';
    return BlocProvider(
      create: (context) =>
          ServicesCubit(PaymentRepository())..getPaymentsHistory(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(245, 244, 244, 2),
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
            'Services',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        body: BlocConsumer<ServicesCubit, ServiceState>(
          listener: (context, state) {
            if (state.status.isLoading) {
              totalPrice = 'caculating...';
            } else if (state.status.isLoaded) {
              totalPrice = state.totalPrice;
              totalPrice = totalPrice + " VNĐ";
            } else if (state.status.isLoadError) {
              totalPrice = 'caculate error';
            }
          },
          builder: (context, state) {
            return Container(
              alignment: Alignment.center,
              height: SizeConfig.blockSizeVertical * 100,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.WALLET);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 5,
                                right: SizeConfig.blockSizeHorizontal * 5),
                            width: SizeConfig.blockSizeHorizontal * 95,
                            height: SizeConfig.blockSizeVertical * 23,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color.fromRGBO(64, 201, 162, 1),
                                    const Color.fromRGBO(64, 201, 162, 1),
                                    const Color.fromRGBO(30, 193, 194, 30),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.1),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  height: SizeConfig.blockSizeVertical * 10,
                                  child:
                                      Image.asset("assets/images/app_logo.png"),
                                ),
                                Container(
                                  child: Text(
                                    'Your spendings on this year',
                                    style: GoogleFonts.lato(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1.5,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        totalPrice,
                                        style: GoogleFonts.lato(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            BlocProvider.of<ServicesCubit>(
                                                    context)
                                                .getPaymentsHistory();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.refresh,
                                            color: Colors.white,
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 2),
                          child: Text(
                            'Ask Specialist',
                            style: GoogleFonts.lato(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 99, 99, 30)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.SPECIALISTS);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    width: SizeConfig.blockSizeHorizontal * 95,
                                    height: SizeConfig.blockSizeVertical * 22,
                                    image: AssetImage(
                                        'assets/images/utilities_banner.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0),
                                            Colors.black,
                                          ],
                                          stops: [
                                            0.0,
                                            2.0
                                          ])),
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1,
                                      right: SizeConfig.blockSizeHorizontal * 1,
                                      bottom:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  alignment: Alignment.bottomLeft,
                                  width: SizeConfig.blockSizeHorizontal * 95,
                                  height: SizeConfig.blockSizeVertical * 22,
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        SizeConfig.blockSizeHorizontal * 1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          'Find your specialist',
                                          style: GoogleFonts.lato(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Container(
                                          width:
                                              SizeConfig.blockSizeVertical * 30,
                                          child: Text(
                                            'Have an appointment with specialists, they will help you to solve your problems.',
                                            style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 2),
                          child: Text(
                            'Learn Vietnamese',
                            style: GoogleFonts.lato(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 99, 99, 30)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.VIETNAMESE_LEARN);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    width: SizeConfig.blockSizeHorizontal * 95,
                                    height: SizeConfig.blockSizeVertical * 22,
                                    image: AssetImage(
                                        'assets/images/utilities_banner_2.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0),
                                            Colors.black,
                                          ],
                                          stops: [
                                            0.0,
                                            2.0
                                          ])),
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1,
                                      right: SizeConfig.blockSizeHorizontal * 1,
                                      bottom:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  alignment: Alignment.bottomLeft,
                                  width: SizeConfig.blockSizeHorizontal * 95,
                                  height: SizeConfig.blockSizeVertical * 22,
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        SizeConfig.blockSizeHorizontal * 1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          'Learn Vietnamese',
                                          style: GoogleFonts.lato(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Container(
                                          width:
                                              SizeConfig.blockSizeVertical * 30,
                                          child: Text(
                                            'Learn Vietnamese through vocabulary and sentence to improve your Vietnamese skill',
                                            style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
