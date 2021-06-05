import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/material.dart';

void showCorrectDialog({@required BuildContext context, @required Function action, @required String vietnamese, @required String english}){
  SizeConfig().init(context);
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          contentPadding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
          content: Container(
            width: SizeConfig.blockSizeHorizontal * 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Correct'),
                SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 10,
                  padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 3),
                  child: Column(
                    children: <Widget>[
                      Text(vietnamese),
                      Text(english)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    action();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        bottom: SizeConfig.blockSizeVertical * 2),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(30, 193, 194, 30),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
  );
}