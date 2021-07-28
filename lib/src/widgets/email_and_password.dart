import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/email_password_cubit.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/states/email_password_state.dart';
import 'package:expat_assistant/src/models/email_validate.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EmailAndPassword extends StatefulWidget {
  Function buttonAction;
  Expat expat;

  EmailAndPassword({this.buttonAction, this.expat});

  @override
  _EmailAndPasswordState createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword>
    with AutomaticKeepAliveClientMixin {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => EmailPasswordCubit(),
      child: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 2,
            right: SizeConfig.safeBlockHorizontal * 2),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Text(
              'Email and password',
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
                'Finally, Please add your email and password',
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
            BlocBuilder<EmailPasswordCubit, EmailPasswordState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return Container(
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      errorStyle: GoogleFonts.lato(),
                      errorText: state.email.error.name,
                      hintText: 'Enter your Email',
                      hintStyle: GoogleFonts.lato(),
                      hoverColor: Color.fromRGBO(30, 193, 194, 30),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (email) {
                      BlocProvider.of<EmailPasswordCubit>(context)
                          .emailChange(email);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Password',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            BlocBuilder<EmailPasswordCubit, EmailPasswordState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (context, state) {
                return Container(
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      errorStyle: GoogleFonts.lato(),
                      errorText: state.password.error.name,
                      hintText: 'Enter your password',
                      hintStyle: GoogleFonts.lato(),
                      hoverColor: Color.fromRGBO(30, 193, 194, 30),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (password) {
                      BlocProvider.of<EmailPasswordCubit>(context)
                          .passwordChange(password);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            BlocBuilder<EmailPasswordCubit, EmailPasswordState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return SizedBox(
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
                        "Next",
                        style:
                            GoogleFonts.lato(fontSize: 17, color: Colors.white),
                      ),
                      onPressed: () {
                        if (state.status.isValidated) {
                          widget.expat.email = emailController.text.trim();
                          widget.expat.password =
                              passwordController.text.trim();
                          widget.buttonAction();
                        }
                      }),
                );
              },
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
