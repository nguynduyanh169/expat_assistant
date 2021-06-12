import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      //backgroundColor: Color.fromRGBO(245, 244, 244, 5),
      body: login(context),
    );
  }

  Widget login(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 90,
          child: Column(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 38,
                height: SizeConfig.blockSizeVertical * 38,
                child: Image.asset("assets/images/app_logo.png"),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Email', style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),),
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: GoogleFonts.lato(),
                    hoverColor: Color.fromRGBO(30, 193, 194, 30),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Password', style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),),
              ),
              Container(
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: GoogleFonts.lato(),
                    suffix: InkWell(
                      onTap: (){
                        print('ok');
                      },
                      child: Icon(
                        Icons.remove_red_eye
                      ),
                    ),
                    hoverColor: Color.fromRGBO(30, 193, 194, 30),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot your password?",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(30, 193, 194, 30)),
                      textStyle: MaterialStateProperty.all<TextStyle>(GoogleFonts.lato(fontSize: 17))
                    ),
                    //: Color.fromRGBO(30, 193, 194, 30),
                    child: Text("Sign In"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/homePage');
                    }),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Container(
                child: Text(
                    "Or, Sign in with",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 30,
                        height: SizeConfig.blockSizeVertical * 9,
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26.withOpacity(0.1),
                                  offset: Offset(0.0, 6.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.10)
                            ]),
                        child: Image.asset('assets/images/facebook_logo.png'),
                      ),
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 10,),
                    InkWell(
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 30,
                        height: SizeConfig.blockSizeVertical * 9,
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26.withOpacity(0.1),
                                  offset: Offset(0.0, 6.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.10)
                            ]),
                        child: Image.asset('assets/images/google_logo.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Container(
                child: Text(
                  "Does not have any account? Sign up",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
