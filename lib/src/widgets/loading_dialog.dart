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
              padding: const EdgeInsets.all(70.0),
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  SizedBox(height: 30,),
                  Text('Loading....', style: GoogleFonts.lato(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w500),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}