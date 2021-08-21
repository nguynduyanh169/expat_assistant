import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/change_password_cubit.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/change_password_state.dart';
import 'package:expat_assistant/src/models/password_validate.dart';
import 'package:expat_assistant/src/models/old_password_validate.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:formz/formz.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  bool showPassword = false;
  bool showOldPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(UserRepository()),
      child: Scaffold(
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
            'Change password',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      if (state.status.isValidated) {
                        BlocProvider.of<ChangePasswordCubit>(context)
                            .changePassword(_newPassword.text.trim());
                      }
                    },
                    icon: Icon(CupertinoIcons.check_mark));
              },
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state.status.isSubmissionInProgress) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Please wait...');
            } else if (state.status.isSubmissionFailure) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'An error occurs while changing password',
                  color: Colors.red);
            } else if (state.status.isSubmissionSuccess) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'Change password success',
                  color: Colors.green);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Old Password',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    buildWhen: (previous, current) =>
                        previous.oldPassword != current.oldPassword,
                    builder: (context, state) {
                      return TextFormField(
                        controller: _oldPassword,
                        style: GoogleFonts.lato(),
                        obscureText: !showOldPassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your old password',
                          errorText: state.oldPassword.error.name,
                          errorStyle: GoogleFonts.lato(),
                          hintStyle: GoogleFonts.lato(),
                          suffix: InkWell(
                              onTap: () {
                                if (showOldPassword == true) {
                                  setState(() {
                                    showOldPassword = false;
                                  });
                                } else {
                                  setState(() {
                                    showOldPassword = true;
                                  });
                                }
                              },
                              child: Icon(showOldPassword
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
                        onChanged: (oldPassword) {
                          BlocProvider.of<ChangePasswordCubit>(context)
                              .oldPasswordChanged(oldPassword);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'New Password',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                    buildWhen: (previous, current) =>
                        previous.password != current.password,
                    builder: (context, state) {
                      return TextFormField(
                        controller: _newPassword,
                        obscureText: !showPassword,
                        style: GoogleFonts.lato(),
                        decoration: InputDecoration(
                          errorText: state.password.error.name,
                          errorStyle: GoogleFonts.lato(),
                          hintText: 'Enter your new password',
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
                          BlocProvider.of<ChangePasswordCubit>(context)
                              .passwordChanged(password);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
