import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: login(context),
    );
  }

  Widget login(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white10,
          width: SizeConfig.blockSizeHorizontal * 90,
          child: Column(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 40,
                height: SizeConfig.blockSizeVertical * 40,
                child: Image.asset("assets/images/app_logo.png"),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontWeight: FontWeight.w400),
                      prefixIcon: Icon(CupertinoIcons.mail_solid)),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontWeight: FontWeight.w400),
                      prefixIcon: Icon(CupertinoIcons.lock_fill)),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 85,
                child: CupertinoButton(
                    color: Color.fromRGBO(30, 193, 194, 30),
                    child: Text("Sign In"),
                    onPressed: () {
                      print('Login');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen()));
                    }),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Container(
                child: Text(
                    "Or, Sign in with",
                  style: TextStyle(
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
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 39,
                      child: CupertinoButton(
                          color: Colors.black12,
                          child: Image.asset('assets/images/facebook_logo.png'),
                          onPressed: () {
                            print('Login');
                          }),
                    ),
                    SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 39,
                      child: CupertinoButton(
                          color: Colors.black12,
                          child: Image.asset('assets/images/google_logo.png'),
                          onPressed: () {
                            print('Login');
                          }),
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
                  style: TextStyle(
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
