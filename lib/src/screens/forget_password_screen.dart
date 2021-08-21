import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/cubits/forget_password_cubit.dart';
import 'package:expat_assistant/src/states/forget_password_state.dart';
import 'package:expat_assistant/src/widgets/send_confirm_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String email;

  void sendEmail(String email, BuildContext context){
    BlocProvider.of<ForgetPasswordCubit>(context)
                      .sendEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black38,
                height: 0.25,
              ),
              preferredSize: Size.fromHeight(0.25)),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.MAIN_COLOR,
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            'Forget Password',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            builder: (context, state) {
              return SendConfirmEmail(
                email: email,
                rootContext: context,
                sendEmail: sendEmail,
              );
            },
          ),
        ),
      ),
    );
  }
}
