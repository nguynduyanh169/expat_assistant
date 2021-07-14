import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmEmail extends StatefulWidget {
  @override
  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  Function buttonAction;
  TextEditingController otpController = TextEditingController();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 2,
          right: SizeConfig.safeBlockHorizontal * 2),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Text(
            'Email verification',
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            child: Text(
              'Finally, Please enter code sent to anhnd16091998@gmail.com',
              style: GoogleFonts.lato(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          PinCodeTextField(
              keyboardType: TextInputType.number,
              appContext: context,
              pastedTextStyle: GoogleFonts.lato(),
              textStyle: GoogleFonts.lato(),
              obscureText: false,
              animationType: AnimationType.fade,
              length: 6,
              validator: (v) {
                if (v.length < 3) {
                  return "I'm from validator";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                fieldHeight: 60,
                fieldWidth: 50,
                activeFillColor: _hasError ? Colors.red : Colors.white,
              ),
              cursorColor: Colors.black,
              animationDuration: Duration(milliseconds: 300),
              onChanged: (value) {
                setState(() {});
              }),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 85,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.MAIN_COLOR),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.lato(fontSize: 17, color: Colors.white))),
                child: Text(
                  "Verify",
                  style: GoogleFonts.lato(fontSize: 17, color: Colors.white),
                ),
                onPressed: (){

                }),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 30,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account?",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600, color: Colors.green),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
