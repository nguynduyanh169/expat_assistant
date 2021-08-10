import 'dart:convert';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/invoice_cubit.dart';
import 'package:expat_assistant/src/models/payment.dart';
import 'package:expat_assistant/src/models/session.dart';
import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/providers/payment_provider.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/repositories/payment_repository.dart';
import 'package:expat_assistant/src/screens/payment_done_screen.dart';
import 'package:expat_assistant/src/states/invoice_state.dart';
import 'package:expat_assistant/src/utils/rsa_utils.dart';
import 'package:expat_assistant/src/utils/text_utils.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:momo_vn/momo_vn.dart';

// ignore: must_be_immutable
class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  SessionDisplay selectedSession;
  SpecialistDetails specialistDetails;
  String channelName;
  TextUtils _textUtils = TextUtils();
  PaymentProvider paymentProvider = PaymentProvider();
  MomoVn momoPay;
  String paymentStatus;
  PaymentResponse momoPaymentResult;
  BuildContext screenContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as InvoiceScreenArguments;
    selectedSession = args.selectedSession;
    specialistDetails = args.specialistDetails;
    channelName = TextUtils.getChannel();
    return BlocProvider(
      create: (context) =>
          InvoiceCubit(AppointmentRepository(), PaymentRepository()),
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
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'Confirm Appointment',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        body: BlocConsumer<InvoiceCubit, InvoiceState>(
          listener: (context, state) {
            if (state.status.isRegistryingSessionFailed) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'An error occur while registry session',
                  color: Colors.red);
            } else if (state.status.isRegistryingSessionSuccess) {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteName.PAYMENT_DONE,
                  arguments: PaymentDoneArgs(
                      selectedSession, channelName, specialistDetails));
            } else if (state.status.isPayingWithMomo) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Please wait...');
            } else if (state.status.isPayWithMomoSuccess) {
              print('object');
              BlocProvider.of<InvoiceCubit>(context).registrySessions(
                  selectedSession, state.paymentRespone, channelName);
            } else if (state.status.isPayWithMomoFailed) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context, message: state.message, color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state.status.isInit) {
              momoPay = MomoVn();
              momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
              momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, handlePaymentError);
              screenContext = context;
            }
            return Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.05),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.10)
                        ]),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: ExtendedImage.network(
                            specialistDetails.specialist.avatar,
                            fit: BoxFit.cover,
                            width: SizeConfig.blockSizeHorizontal * 26,
                            height: SizeConfig.blockSizeVertical * 14,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        Text(
                          specialistDetails.specialist.fullname,
                          style: GoogleFonts.lato(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.yMMMMd()
                              .format(selectedSession.dateOfSession),
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 33,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Text(
                                  'Duration: ',
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Text(
                                    selectedSession.startTime +
                                        " - " +
                                        selectedSession.endTime,
                                    style: GoogleFonts.lato()),
                              ),
                              ListTile(
                                leading: Text(
                                  'Major: ',
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Text(
                                    specialistDetails.majors.first.name,
                                    style: GoogleFonts.lato()),
                              ),
                              ListTile(
                                leading: Text(
                                  'Language: ',
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Text(
                                    _textUtils.getLanguages(
                                        languages: specialistDetails.language),
                                    style: GoogleFonts.lato()),
                              ),
                              ListTile(
                                leading: Text(
                                  'Channel: ',
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Text(channelName,
                                    style: GoogleFonts.lato()),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          leading: Text(
                            'Price: ',
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          trailing: Text('${selectedSession.price} VND',
                              style: GoogleFonts.lato()),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 100,
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 10,
                          right: SizeConfig.blockSizeHorizontal * 10,
                          top: SizeConfig.blockSizeVertical * 1.75,
                          bottom: SizeConfig.blockSizeVertical * 1.75),
                      height: SizeConfig.blockSizeVertical * 10,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 70,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 2)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.MAIN_COLOR),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  GoogleFonts.lato(fontSize: 17))),
                          child: Text("Pay Now"),
                          onPressed: () {
                            // BlocProvider.of<InvoiceCubit>(context)
                            //     .registrySessions(sessions);
                            MomoPaymentInfo options = MomoPaymentInfo(
                                merchantName: "Dịch vụ giải đáp với chuyên gia",
                                merchantCode: MomoConstants.MERCHANT_CODE,
                                partnerCode: MomoConstants.PARTNER_CODE,
                                appScheme: MomoConstants.APP_SCHEME,
                                orderId: TextUtils.getOrderId(),
                                amount: selectedSession.price.toInt(),
                                merchantNameLabel: "Hẹn tư vấn",
                                fee: 0,
                                description:
                                    'Thanh toán lịch hẹn với chuyên gia ${specialistDetails.specialist.fullname}',
                                partner: 'merchant',
                                extra:
                                    "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                                isTestMode: true);
                            try {
                              momoPay.open(options);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void handlePaymentError(PaymentResponse response) {
    setState(() {
      momoPaymentResult = response;
    });
    print("THẤT BẠI: " + response.message.toString());
  }

  void handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      momoPaymentResult = response;
    });
    PaymentRequest paymentRequest = PaymentRequest(
        partnerCode: MomoConstants.PARTNER_CODE,
        partnerRefId: TextUtils.getRefId(),
        partnerTransId: TextUtils.getTransId(),
        amount: selectedSession.price.toInt());
    String paymentRequesJson = jsonEncode(paymentRequest.toJson());
    RSAUtils rsaUtils = RSAUtils(MomoConstants.PUB_KEY);
    Payment payment = Payment(
        customerNumber: response.phoneNumber,
        appData: response.token.trim(),
        partnerCode: paymentRequest.partnerCode,
        partnerRefId: paymentRequest.partnerRefId,
        hash: rsaUtils.encryptStr(utf8.encode(paymentRequesJson)),
        description:
            'Thanh toán lịch hẹn với chuyên gia ${specialistDetails.specialist.fullname}',
        version: 2);
    BlocProvider.of<InvoiceCubit>(screenContext).paymentWithMomo(payment);
  }
}

class InvoiceScreenArguments {
  final SessionDisplay selectedSession;
  final SpecialistDetails specialistDetails;
  const InvoiceScreenArguments(this.selectedSession, this.specialistDetails);
}
