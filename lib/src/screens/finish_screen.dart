import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args = ModalRoute.of(context).settings.arguments
    as FinishScreenArugments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 5,),
            Container(
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 24,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/finish_lesson.png'),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 5,),
            Container(
              child: Text(
                'Congratulations', style: GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 35),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 3,),
            Container(
              width: SizeConfig.blockSizeHorizontal * 70,
              child: Text(
                'You have finish ${args.vocabularyLenght.toString()} vocabulary. Keep up with this!', style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 10,),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty
                          .all<EdgeInsets>(EdgeInsets.all(
                          SizeConfig.blockSizeHorizontal * 4)),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(
                          AppColors.MAIN_COLOR),
                      textStyle:
                      MaterialStateProperty.all<TextStyle>(
                          GoogleFonts.lato(fontSize: 17))),
                  //: Color.fromRGBO(30, 193, 194, 30),
                  child: Text("Learn other lessons"),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName(RouteName.VIETNAMESE_LEARN));
                  }),
            )
          ],
        ),
      ),
    );
  }

}

class FinishScreenArugments{
  final int vocabularyLenght;

  FinishScreenArugments(this.vocabularyLenght);
}


class FinishScreenForConversation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args = ModalRoute.of(context).settings.arguments
    as FinishScreenForConversationArugments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 5,),
            Container(
              child: Image(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 24,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/finish_lesson.png'),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 5,),
            Container(
              child: Text(
                'Congratulations', style: GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 35),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 3,),
            Container(
              width: SizeConfig.blockSizeHorizontal * 70,
              child: Text(
                'You have finish ${args.conversationLength.toString()} conversation. Keep up with this!', style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 10,),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty
                          .all<EdgeInsets>(EdgeInsets.all(
                          SizeConfig.blockSizeHorizontal * 4)),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(
                          AppColors.MAIN_COLOR),
                      textStyle:
                      MaterialStateProperty.all<TextStyle>(
                          GoogleFonts.lato(fontSize: 17))),
                  //: Color.fromRGBO(30, 193, 194, 30),
                  child: Text("Learn other lessons"),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName(RouteName.VIETNAMESE_LEARN));
                  }),
            )
          ],
        ),
      ),
    );
  }

}


class FinishScreenForConversationArugments{
  final int conversationLength;

  FinishScreenForConversationArugments(this.conversationLength);
}

