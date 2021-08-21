import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/confim_email_cubit.dart';
import 'package:expat_assistant/src/states/confirm_email_state.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class ConfirmEmail extends StatefulWidget {
  Function buttonAction;
  Function confirmEmailButton;
  String email;
  int code;
  ConfirmEmail(
      {this.buttonAction, this.code, this.email, this.confirmEmailButton});
  @override
  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  TextEditingController otpController = TextEditingController();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => ConfirmEmailCubit(),
      child: BlocConsumer<ConfirmEmailCubit, ConfirmEmailState>(
        listener: (context, state) {
          if (state.status.isResendCode) {
            CustomLoadingDialog.loadingDialog(
                context: context, message: 'Resend code...');
          } else if (state.status.isResendedCode) {
            Navigator.pop(context);
            widget.code = state.code;
          } else if (state.status.isResendCodeError) {
            Navigator.pop(context);
            CustomSnackBar.showSnackBar(
                context: context,
                message: 'An error occurs while sending code',
                color: Colors.red);
          }
        },
        builder: (context, state) {
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
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: Text(
                    'Please enter code sent to ${widget.email}',
                    style: GoogleFonts.lato(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                PinCodeTextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    appContext: context,
                    pastedTextStyle: GoogleFonts.lato(),
                    textStyle: GoogleFonts.lato(),
                    obscureText: false,
                    animationType: AnimationType.fade,
                    length: 6,
                    validator: (v) {
                      if (v.length < 6) {
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
                              EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal * 4)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.MAIN_COLOR),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              GoogleFonts.lato(
                                  fontSize: 17, color: Colors.white))),
                      child: Text(
                        "Verify",
                        style:
                            GoogleFonts.lato(fontSize: 17, color: Colors.white),
                      ),
                      onPressed: () {
                        if (widget.code ==
                            int.parse(otpController.text.toString())) {
                          widget.buttonAction();
                        }
                      }),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Does not receive code?",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600, color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: widget.confirmEmailButton,
                          child: Text(
                            'Resend Email',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ))
                    ],
                  ),
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
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
