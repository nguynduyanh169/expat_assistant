import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/sign_up_cubit.dart';
import 'package:expat_assistant/src/states/sign_up_state.dart';
import 'package:expat_assistant/src/widgets/confirm_email.dart';
import 'package:expat_assistant/src/widgets/email_and_password.dart';
import 'package:expat_assistant/src/widgets/full_name_and_phone.dart';
import 'package:expat_assistant/src/widgets/laguage_and_nation.dart';
import 'package:expat_assistant/src/widgets/welcome_sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  void addFullnameAndPhone(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => SignUpCubit(),
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
            'Create your account',
            style: GoogleFonts.lato(fontSize: 22, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
            if (state.status.isInit) {
              return WelcomeSignUp(
                buttonAction: () =>
                    BlocProvider.of<SignUpCubit>(context).addFullnameAndPhone(),
              );
            } else if (state.status.isAddFullnameAndPhone) {
              return FullnameAndPhone(
                buttonAction: () =>
                    BlocProvider.of<SignUpCubit>(context).addLanguageAndNation(),
              );
            } else if (state.status.isAddLanguageAndNation) {
              return LanguageAndNation(
                buttonAction: () =>
                    BlocProvider.of<SignUpCubit>(context).addEmailAndPassword(),
              );
            } else if (state.status.isAddEmailAndPassword) {
              return EmailAndPassword(
                buttonAction: () =>
                    BlocProvider.of<SignUpCubit>(context).confirmEmail(),
              );
            } else {
              return ConfirmEmail();
            }
          }),
        ),
      ),
    );
  }
}
