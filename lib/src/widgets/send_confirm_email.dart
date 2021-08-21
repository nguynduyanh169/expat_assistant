import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SendConfirmEmail extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  Function sendEmail;
  String email;
  BuildContext rootContext;

  SendConfirmEmail({this.sendEmail, this.email, this.rootContext});
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
            'Enter your account email',
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            child: Text(
              'Enter your email and press send to receive confirmation email from us.',
              style: GoogleFonts.lato(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Email',
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Container(
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: GoogleFonts.lato(),
                hoverColor: Color.fromRGBO(30, 193, 194, 30),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
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
                  "Send",
                  style: GoogleFonts.lato(fontSize: 17, color: Colors.white),
                ),
                onPressed: () {
                  email = emailController.text.trim();
                  sendEmail(emailController.text.trim(), rootContext);
                }),
          )
        ],
      ),
    );
  }
}
