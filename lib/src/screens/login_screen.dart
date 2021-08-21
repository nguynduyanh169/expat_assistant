import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/login_cubit.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/login_state.dart';
import 'package:expat_assistant/src/models/email_validate.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _txtEmail = new TextEditingController();

  TextEditingController _txtPassword = new TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          CustomSnackBar.showSnackBar(
              context: context,
              message: 'Incorrect email or password',
              color: Colors.red);
        } else if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, RouteName.HOME_PAGE);
        } else if (state.status.isSubmissionInProgress) {
          CustomLoadingDialog.loadingDialog(
              context: context, message: 'Logging in...');
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
                    height: SizeConfig.blockSizeVertical * 30,
                    child: Image.asset("assets/images/app_logo.png"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome Back',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign in to continue',
                      style:
                          GoogleFonts.lato(color: Colors.black54, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 8,
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
                              errorStyle: GoogleFonts.lato(),
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
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            errorText: state.password.error.name,
                            hintText: 'Enter your password',
                            hintStyle: GoogleFonts.lato(),
                            suffix: InkWell(
                              onTap: () {
                                if (showPassword == true) {
                                  setState(() {
                                    showPassword = false;
                                  });
                                } else {
                                  setState(() {
                                    showPassword = true;
                                  });
                                }
                              },
                              child: Icon(showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
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
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteName.FORGET_PASSWORD),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot your password?",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600, color: Colors.black54),
                      ),
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
                                          AppColors.MAIN_COLOR),
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                          GoogleFonts.lato(fontSize: 17))),
                              child: Text("Sign In"),
                              onPressed: () {
                                if (state.status.isValidated) {
                                  BlocProvider.of<LoginCubit>(context)
                                      .loginWithCredential(
                                          email: _txtEmail.text,
                                          password: _txtPassword.text);
                                }
                              }),
                        );
                      }),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Does not have any account?",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RouteName.SIGN_UP);
                            },
                            child: Text(
                              'Sign up',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.MAIN_COLOR),
                            ))
                      ],
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
