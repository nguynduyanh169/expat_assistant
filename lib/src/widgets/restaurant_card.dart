import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
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
      child: Row(
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal * 40,
            height: SizeConfig.blockSizeVertical * 20,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/demo_food.jpg'),
              ),
            ),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 20,
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
                  width: SizeConfig.blockSizeHorizontal * 40,
                  height: SizeConfig.blockSizeVertical * 4,
                  child: Text(
                    'Phở Hoà',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        CupertinoIcons.placemark,
                        size: 15,
                        color: Color.fromRGBO(30, 193, 194, 30),
                      ),
                    ),
                    Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        child: Text(
                          '260C Pasteur, P. 8, Quận 3, TP. HCM',
                          style: TextStyle(fontSize: 13),
                        ))
                  ],
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        CupertinoIcons.clock,
                        size: 15,
                        color: Color.fromRGBO(30, 193, 194, 30),
                      ),
                    ),
                    Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        child: Text(
                          '12:00 - 22:00',
                          style: TextStyle(fontSize: 13),
                        ))
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
