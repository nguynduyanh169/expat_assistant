import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/color_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LoadingView extends StatelessWidget {
  String message;
  LoadingView({@required this.message});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ColorLoader4(
              dotOneColor: Colors.redAccent,
              dotTwoColor: Colors.green,
              dotThreeColor: Colors.blueAccent,
              duration: Duration(seconds: 2),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              message,
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoadingViewForRestaurant extends StatelessWidget {
 String message;
  LoadingViewForRestaurant({@required this.message});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(width: SizeConfig.blockSizeHorizontal * 30, height: SizeConfig.blockSizeHorizontal * 30, image: AssetImage('assets/images/map.png')),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              message,
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
