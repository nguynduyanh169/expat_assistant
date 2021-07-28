import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/fullname_phone_cubit.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/models/phone_validate.dart';
import 'package:expat_assistant/src/models/fullname_validate.dart';
import 'package:expat_assistant/src/states/fullname_phone_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:formz/formz.dart';

// ignore: must_be_immutable
class FullnameAndPhone extends StatefulWidget {
  Function buttonAction;
  Expat expat;

  FullnameAndPhone({this.buttonAction, this.expat});

  @override
  _FullnameAndPhoneState createState() => _FullnameAndPhoneState();
}

class _FullnameAndPhoneState extends State<FullnameAndPhone>
    with AutomaticKeepAliveClientMixin {
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => FullnamePhoneCubit(),
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
              'Full name and phone number',
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
                'First, Please add your full name and phone number',
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
                'Full Name',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            BlocBuilder<FullnamePhoneCubit, FullnamePhoneState>(
              buildWhen: (previous, current) =>
                  previous.fullname != current.fullname,
              builder: (context, state) {
                return Container(
                  child: TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      errorStyle: GoogleFonts.lato(),
                      errorText: state.fullname.error.name,
                      hintText: 'Enter your full name',
                      hintStyle: GoogleFonts.lato(),
                      hoverColor: Color.fromRGBO(30, 193, 194, 30),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (fullname) {
                      BlocProvider.of<FullnamePhoneCubit>(context)
                          .fullnameChange(fullname);
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
                'Phone',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            BlocBuilder<FullnamePhoneCubit, FullnamePhoneState>(
              buildWhen: (previous, current) => previous.phone != current.phone,
              builder: (context, state) {
                return Container(
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      errorStyle: GoogleFonts.lato(),
                      errorText: state.phone.error.name,
                      hintText: 'Enter your phone',
                      hintStyle: GoogleFonts.lato(),
                      hoverColor: Color.fromRGBO(30, 193, 194, 30),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (phone) {
                      BlocProvider.of<FullnamePhoneCubit>(context)
                          .phoneChange(phone);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            BlocBuilder<FullnamePhoneCubit, FullnamePhoneState>(
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
                          widget.expat.fullname =
                              fullNameController.text.trim();
                          widget.expat.phone = phoneController.text.trim();
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
