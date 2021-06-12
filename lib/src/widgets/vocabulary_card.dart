import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VocabularyCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 3,
          bottom: SizeConfig.blockSizeVertical * 2,
          left: SizeConfig.blockSizeHorizontal * 2,
          right: SizeConfig.blockSizeHorizontal * 3),
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
      child: ListTile(
        leading: Image(
          width: SizeConfig.blockSizeHorizontal * 15,
          height: SizeConfig.blockSizeVertical * 15,
          image: AssetImage('assets/images/demo_vocabulary.png'),
        ),
        title: Text('Discuss', style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w600),),
        subtitle: Text('Thảo luận', style: GoogleFonts.lato(fontSize: 18)),
        trailing: CircleAvatar(
          backgroundColor: Color.fromRGBO(30, 193, 194, 30),
          radius: 25,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(CupertinoIcons.play_arrow_solid),
            color: Colors.white,
            onPressed: () {
              print("play");
            },
          ),
        ),
      ),
    );
  }

}