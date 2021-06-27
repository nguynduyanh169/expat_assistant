import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 15,
              fit: BoxFit.fill,
              image: AssetImage('assets/images/folder.png')),
          SizedBox(height: SizeConfig.blockSizeVertical * 3,),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            height: SizeConfig.blockSizeVertical * 15,
            child: Text('Sorry, No result found',
                style: GoogleFonts.lato(
                    fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}
