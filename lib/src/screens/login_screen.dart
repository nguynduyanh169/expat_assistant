import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/login_cubit.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/login_state.dart';
import 'package:expat_assistant/src/models/email_validate.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _txtEmail = new TextEditingController();
  TextEditingController _txtPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(UserRepository()),
        child: login(context),
      ),
    );
  }

  Widget login(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
            content: Text(
              'Your email or password is not correct!',
              style: GoogleFonts.lato(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            duration: const Duration(milliseconds: 1500),
            // width: SizeConfig.blockSizeHorizontal * 60,
            // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.fixed,
          ));
        }else if(state.status.isSubmissionSuccess){
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/homePage');
        }else if(state.status.isSubmissionInProgress){
          CustomLoadingDialog.loadingDialog(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 40,
                    height: SizeConfig.blockSizeVertical * 35,
                    child: Image.asset("assets/images/app_logo.png"),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Email',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.email != current.email,
                      builder: (context, state) {
                        return Container(
                          child: TextFormField(
                            controller: _txtEmail,
                            decoration: InputDecoration(
                              errorText: state.email.error.name,
                              hintText: 'Enter your email',
                              hintStyle: GoogleFonts.lato(),
                              hoverColor: Color.fromRGBO(30, 193, 194, 30),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            onChanged: (email) {
                              BlocProvider.of<LoginCubit>(context)
                                  .emailChanged(email);
                            },
                          ),
                        );
                      }),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Password',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.password != current.password,
                    builder: (context, state) {
                      return Container(
                        child: TextFormField(
                          controller: _txtPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: state.password.error.name,
                            hintText: 'Enter your password',
                            hintStyle: GoogleFonts.lato(),
                            suffix: InkWell(
                              onTap: () {
                                print('ok');
                              },
                              child: Icon(Icons.remove_red_eye),
                            ),
                            hoverColor: Color.fromRGBO(30, 193, 194, 30),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          onChanged: (password) {
                            BlocProvider.of<LoginCubit>(context)
                                .passwordChanged(password);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot your password?",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600, color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        return SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 85,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty
                                      .all<EdgeInsets>(EdgeInsets.all(
                                          SizeConfig.blockSizeHorizontal * 4)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(30, 193, 194, 30)),
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                          GoogleFonts.lato(fontSize: 17))),
                              //: Color.fromRGBO(30, 193, 194, 30),
                              child: Text("Sign In"),
                              onPressed: () {
                                if(state.status.isValidated){
                                  BlocProvider.of<LoginCubit>(context).loginWithCredential(email: _txtEmail.text, password: _txtPassword.text);
                                }
                                //Navigator.pushNamed(context, '/homePage');
                              }),
                        );
                      }),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    child: Text(
                      "Or, Sign in with",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600, color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 30,
                            height: SizeConfig.blockSizeVertical * 9,
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.1),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child:
                                Image.asset('assets/images/facebook_logo.png'),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 10,
                        ),
                        InkWell(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 30,
                            height: SizeConfig.blockSizeVertical * 9,
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.1),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child: Image.asset('assets/images/google_logo.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    child: Text(
                      "Does not have any account? Sign up",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
