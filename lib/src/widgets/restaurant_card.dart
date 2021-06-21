import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class RestaurantCard extends StatelessWidget {
  Function restaurantAction;

  RestaurantCard({this.restaurantAction});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: restaurantAction,
      child: Container(
        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal * 3),
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
              width: SizeConfig.blockSizeHorizontal * 30,
              height: SizeConfig.blockSizeVertical * 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/demo_food.jpg'),
                ),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 20,
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3, bottom: SizeConfig.blockSizeVertical * 3, left: SizeConfig.blockSizeHorizontal * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    width: SizeConfig.blockSizeHorizontal * 40,
                    height: SizeConfig.blockSizeVertical * 3,
                    child: Text(
                      'Phở Hoà',
                      style: GoogleFonts.lato(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: Text(
                              '0.3 km',
                              style: GoogleFonts.lato(fontSize: 12),
                            )),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Container(
                            child: Text(
                              '.',
                              style: GoogleFonts.lato(fontSize: 12),
                            )),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  LineIcons.starAlt,
                                  color: Color.fromRGBO(252, 191, 7, 30),
                                  size: 14,
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                Container(
                                    child: Text(
                                      '4.5',
                                      style: GoogleFonts.lato(fontSize: 12),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 0.5,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        child: Text(
                          'Phở',
                          style: GoogleFonts.lato(fontSize: 12, color: Colors.black54),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 4.8,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Container(
                        width: SizeConfig.blockSizeHorizontal * 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: Text(
                                  'Opening Now',
                                  style: GoogleFonts.lato(fontSize: 12, color: Colors.green),
                                )),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Container(
                                child: Text(
                                  '.',
                                  style: GoogleFonts.lato(fontSize: 12),
                                )),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      LineIcons.businessTime,
                                      color: Color.fromRGBO(252, 191, 7, 30),
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 1,
                                    ),
                                    Container(
                                        child: Text(
                                          '11:00 - 21:00',
                                          style: GoogleFonts.lato(fontSize: 12),
                                        ))
                                  ],
                                ))
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
