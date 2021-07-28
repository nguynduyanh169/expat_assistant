import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/sign_up_cubit.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/sign_up_state.dart';
import 'package:expat_assistant/src/widgets/confirm_email.dart';
import 'package:expat_assistant/src/widgets/email_and_password.dart';
import 'package:expat_assistant/src/widgets/full_name_and_phone.dart';
import 'package:expat_assistant/src/widgets/laguage_and_nation.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:expat_assistant/src/widgets/welcome_sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  Expat expat;
  int code;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => SignUpCubit(UserRepository()),
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
          child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
            if (state.status.isSignUpSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
                  style: GoogleFonts.lato(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(milliseconds: 1500),
                // width: SizeConfig.blockSizeHorizontal * 60,
                // Width of the SnackBar.
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, // Inner padding for SnackBar content.
                ),
                backgroundColor: AppColors.MAIN_COLOR,
                behavior: SnackBarBehavior.fixed,
              ));
            } else if (state.status.isSigningUp) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Signing up...');
            } else if (state.status.isSignUpFailed) {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
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
            } else if (state.status.isSendingConfirmEmail) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Sending Email...');
            } else if (state.status.isSendConfirmEmailFailed) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "An error occur while sending code to your email",
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
            } else if (state.status.isConfirmEmail) {
              Navigator.pop(context);
            }
          }, builder: (context, state) {
            if (state.status.isInit) {
              expat = Expat(
                  avataLink:
                      'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/expat%2Fuser.png?alt=media&token=b8ddb06c-347e-419b-95e7-d28a30d93c1a');
              return WelcomeSignUp(
                buttonAction: () =>
                    BlocProvider.of<SignUpCubit>(context).addFullnameAndPhone(),
              );
            } else if (state.status.isAddFullnameAndPhone) {
              return FullnameAndPhone(
                expat: expat,
                buttonAction: () => BlocProvider.of<SignUpCubit>(context)
                    .addLanguageAndNation(),
              );
            } else if (state.status.isAddLanguageAndNation) {
              return LanguageAndNation(
                expat: expat,
                buttonAction: () =>
                    BlocProvider.of<SignUpCubit>(context).addEmailAndPassword(),
              );
            } else if (state.status.isAddEmailAndPassword) {
              return EmailAndPassword(
                expat: expat,
                buttonAction: () => BlocProvider.of<SignUpCubit>(context)
                    .confirmEmail(expat.email),
              );
            } else {
              if (state.status.isConfirmEmail) {
                code = state.code;
              }
              return ConfirmEmail(
                code: code,
                buttonAction: () =>
                    BlocProvider.of<SignUpCubit>(context).signUp(expat),
                confirmEmailButton: () => BlocProvider.of<SignUpCubit>(context)
                    .confirmEmail(expat.email),
              );
            }
          }),
        ),
      ),
    );
  }
}
