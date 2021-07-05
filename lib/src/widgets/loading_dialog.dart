import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/widgets/color_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLoadingDialog {
  static void loadingDialog(
      {@required BuildContext context, @required String message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Container(
          child: Center(
            child: Container(
              width: 260.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 40, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ColorLoader3(
                      radius: 15.0,
                      dotRadius: 5.0,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      message,
                      style: GoogleFonts.lato(
                          color: AppColors.MAIN_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
