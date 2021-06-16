import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLoadingDialog {
  static void loadingDialog(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        child: Center(
          child: Container(
            width: 250.0,
            height: 250.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(80.0),
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(
                    color: Color.fromRGBO(30, 193, 194, 30),
                  ),
                  SizedBox(height: 20,),
                  Text('Loading....', style: GoogleFonts.lato(color: Color.fromRGBO(30, 193, 194, 30), fontSize: 20, fontWeight: FontWeight.w700),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}