import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSignUp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 25,
              image: AssetImage('assets/images/sign_up_logo.png'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 7,),
          Text('Join with us', style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),),
          SizedBox(height: SizeConfig.blockSizeVertical * 1,),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            child: Text('We will help you create a new account in a few easy steps', style: GoogleFonts.lato(fontSize: 15), textAlign: TextAlign.center,),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 85,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty
                        .all<EdgeInsets>(EdgeInsets.all(
                        SizeConfig.blockSizeHorizontal * 4)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(
                        Color.fromRGBO(30, 193, 194, 30)),
                    textStyle:
                    MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.lato(fontSize: 17))),
                child: Text("Next"),
                onPressed: () {
                }),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 30,),
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
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('Sign in', style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600, color: Colors.green),))
              ],
            ),
          ),
        ],
      ),
    );
  }

}