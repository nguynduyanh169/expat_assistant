import 'dart:convert';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/payment.dart';
import 'package:expat_assistant/src/providers/payment_provider.dart';
import 'package:expat_assistant/src/utils/rsa_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:momo_vn/momo_vn.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  MomoVn _momoPay;
  PaymentResponse _momoPaymentResult;
  String _paymentStatus;
  PaymentProvider _paymentProvider = PaymentProvider();

  @override
  void initState() {
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    super.initState();
  }

  @override
  void dispose() {
    // _momoPay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Container(
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
                    child: Image.asset("assets/images/app_logo.png"),
                  ),
                  Container(
                    child: Text(
                      'Your spendings on this months',
                      style:
                          GoogleFonts.lato(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Container(
                    child: Text(
                      '3.362.000 VND',
                      style:
                          GoogleFonts.lato(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            InkWell(
              onTap: () async {
                MomoPaymentInfo options = MomoPaymentInfo(
                    merchantName: "CÔNG TY CỔ PHẦN RESO VIỆT NAM",
                    merchantCode: 'MOMO4UYB20210712',
                    partnerCode: 'MOMO4UYB20210712',
                    appScheme: 'momo4uyb20210712',
                    orderId: 'ORDER19981636',
                    amount: 40000,
                    merchantNameLabel: "HẸN TƯ VẤN ORDER19981623",
                    fee: 0,
                    description:
                        'Thanh toán lịch hẹn với chuyên gia Le Quang Bao',
                    partner: 'merchant',
                    extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                    isTestMode: true);
                try {
                  _momoPay.open(options);
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 50,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: AppColors.MAIN_COLOR,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(0.1),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10)
                    ]),
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      LineIcons.wallet,
                      color: Colors.white,
                    ),
                    Text(
                      'Add Money to Wallet',
                      style: GoogleFonts.lato(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3.8,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 49,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.5),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      'Transaction History',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.MAIN_COLOR),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 36.8,
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(
                            LineIcons.phoneVolume,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          title: Text(
                            'Consultant Fee',
                            style: GoogleFonts.lato(),
                          ),
                          subtitle: Text(
                            '20/5/2020 - 11:00',
                            style: GoogleFonts.lato(),
                          ),
                          trailing: Text(
                            '-200.000 VND',
                            style: GoogleFonts.lato(color: Colors.redAccent),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                          height: 2,
                        ),
                        ListTile(
                          leading: Icon(
                            LineIcons.phoneVolume,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          title: Text(
                            'Consultant Fee',
                            style: GoogleFonts.lato(),
                          ),
                          subtitle: Text(
                            '11/5/2020 - 11:00',
                            style: GoogleFonts.lato(),
                          ),
                          trailing: Text(
                            '-200.000 VND',
                            style: GoogleFonts.lato(color: Colors.redAccent),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                          height: 2,
                        ),
                        ListTile(
                          leading: Icon(
                            LineIcons.wallet,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          title: Text(
                            'Add Money',
                            style: GoogleFonts.lato(),
                          ),
                          subtitle: Text(
                            '11/5/2020 - 10:00',
                            style: GoogleFonts.lato(),
                          ),
                          trailing: Text(
                            '+200.000 VND',
                            style: GoogleFonts.lato(
                                color: Color.fromRGBO(30, 193, 194, 30)),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                          height: 2,
                        ),
                        ListTile(
                          leading: Icon(
                            LineIcons.phoneVolume,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          title: Text(
                            'Consultant Fee',
                            style: GoogleFonts.lato(),
                          ),
                          subtitle: Text(
                            '11/5/2020 - 11:00',
                            style: GoogleFonts.lato(),
                          ),
                          trailing: Text(
                            '-200.000 VND',
                            style: GoogleFonts.lato(color: Colors.redAccent),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                          height: 2,
                        ),
                        ListTile(
                          leading: Icon(
                            LineIcons.phoneVolume,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          title: Text(
                            'Consultant Fee',
                            style: GoogleFonts.lato(),
                          ),
                          subtitle: Text(
                            '11/5/2020 - 11:00',
                            style: GoogleFonts.lato(),
                          ),
                          trailing: Text(
                            '-200.000 VND',
                            style: GoogleFonts.lato(color: Colors.redAccent),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                          height: 2,
                        ),
                        ListTile(
                          leading: Icon(
                            LineIcons.phoneVolume,
                            color: Color.fromRGBO(30, 193, 194, 30),
                          ),
                          title: Text(
                            'Consultant Fee',
                            style: GoogleFonts.lato(),
                          ),
                          subtitle: Text(
                            '11/5/2020 - 11:00',
                            style: GoogleFonts.lato(),
                          ),
                          trailing: Text(
                            '-200.000 VND',
                            style: GoogleFonts.lato(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nTình trạng: " + _momoPaymentResult.status.toString();
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra;
      _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
    print(_paymentStatus);
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    PaymentRequest paymentRequest = PaymentRequest(
        partnerCode: 'MOMO4UYB20210712',
        partnerRefId: 'REFID19981595',
        partnerTransId: 'TRANSID19981595',
        amount: 40000);
    String jsonStr = jsonEncode(paymentRequest.toJson());
    RSAUtils rsaUtils = RSAUtils(MomoConstants.PUB_KEY);
    Payment payment = Payment(
        customerNumber: response.phoneNumber,
        appData: _momoPaymentResult.token.trim(),
        partnerCode: paymentRequest.partnerCode,
        partnerRefId: paymentRequest.partnerRefId,
        hash: rsaUtils.encryptStr(utf8.encode(jsonStr)),
        description: 'Thanh toán lịch hẹn với chuyên gia',
        version: 2);
    print('AppData: ' + payment.appData);
    print('RSA: '+ payment.hash);
    _paymentProvider.paymentRequest(payment: payment);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    print("THẤT BẠI: " + response.message.toString());
  }
}
