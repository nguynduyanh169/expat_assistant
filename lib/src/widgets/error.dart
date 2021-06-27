import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DisplayError extends StatelessWidget {
  String message;
  Function reload;

  DisplayError({@required this.message, @required this.reload});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
               width: SizeConfig.blockSizeHorizontal * 50,
               height: SizeConfig.blockSizeVertical * 15,
              // fit: BoxFit.fill,
              image: AssetImage('assets/images/oops.png')),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            height: SizeConfig.blockSizeVertical * 15,
            child: Text(
              'OOPS!',
              style:
                  GoogleFonts.lato(fontSize: 35, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            height: SizeConfig.blockSizeVertical * 15,
            child: Text(
              message,
              style:
                  GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 85,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.lato(fontSize: 17))),
                //: Color.fromRGBO(30, 193, 194, 30),
                child: Text("Try Again"),
                onPressed: reload),
          )
        ],
      ),
    );
  }
}
