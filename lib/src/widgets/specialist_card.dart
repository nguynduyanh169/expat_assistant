import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialistCard extends StatelessWidget{
  Function action;
  SpecialistCard({@required this.action});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: action,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
        decoration: BoxDecoration(
            color:  Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.1),
                  offset: Offset(0.0, 6.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.10)
            ]),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                fit: BoxFit.cover,
                width: SizeConfig.blockSizeHorizontal * 18,
                height: SizeConfig.blockSizeVertical * 8,
                image: AssetImage('assets/images/demo_expert.jpg'),
              ),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Dr. Xuan Cuong Ho', style: GoogleFonts.lato( fontSize: 18, fontWeight: FontWeight.w700),),
                Text('Lawyer', style: GoogleFonts.lato(),),
                SizedBox(height: SizeConfig.blockSizeVertical * 0.7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 14,),
                    Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 14,),
                    Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 14,),
                    Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 14,),
                    Icon(CupertinoIcons.star_fill, color: Colors.yellow, size: 14,),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}