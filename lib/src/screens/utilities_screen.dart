import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class UtilitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 2),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: AppColors.MAIN_COLOR,
        automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Services',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        height: SizeConfig.blockSizeVertical * 100,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.blockSizeHorizontal * 5),
                    width: SizeConfig.blockSizeHorizontal * 95,
                    height: SizeConfig.blockSizeVertical * 23,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color.fromRGBO(64, 201, 162, 1),
                            const Color.fromRGBO(64, 201, 162, 1),
                            const Color.fromRGBO(30, 193, 194, 30),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.1),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.10)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 15,
                          height: SizeConfig.blockSizeVertical * 10,
                          child: Image.asset("assets/images/app_logo.png"),
                        ),
                        Container(
                          child: Text(
                            'Your balance',
                            style: GoogleFonts.lato(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1.5,
                        ),
                        Container(
                          child: Text(
                            '3.362.000 VND',
                            style: GoogleFonts.lato(
                                fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Ask Specialist',
                          style: GoogleFonts.lato(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 99, 99, 30)),
                        ),
                        TextButton(
                            onPressed: (){
                                Navigator.pushNamed(context, RouteName.SPECIALISTS);
                            },
                            child: Text('See more',
                                style: GoogleFonts.lato(
                                    color: Color.fromRGBO(30, 193, 194, 30))))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            width: SizeConfig.blockSizeHorizontal * 95,
                            height: SizeConfig.blockSizeVertical * 22,
                            image: AssetImage(
                                'assets/images/utilities_banner.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                Colors.grey.withOpacity(0),
                                Colors.black,
                              ],
                                  stops: [
                                0.0,
                                2.0
                              ])),
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1,
                              right: SizeConfig.blockSizeHorizontal * 1,
                              bottom: SizeConfig.blockSizeHorizontal * 2),
                          alignment: Alignment.bottomLeft,
                          width: SizeConfig.blockSizeHorizontal * 95,
                          height: SizeConfig.blockSizeVertical * 22,
                          child: Container(
                            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Find your specialist',
                                  style: GoogleFonts.lato(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeVertical * 30,
                                  child: Text(
                                    'Have an appointment with specialists, they will help you to solve your problems.',
                                    style: GoogleFonts.lato(color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                  Container(
                    height: SizeConfig.blockSizeVertical * 5,
                    padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          //width: SizeConfig.blockSizeHorizontal * 30,
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                          child: Row(
                            children: <Widget>[
                              Icon(LineIcons.balanceScale,),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                              Text('Lawyer', style: GoogleFonts.lato())
                            ],
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                        Container(
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                          child: Row(
                            children: <Widget>[
                              Icon(LineIcons.laptop,),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                              Text('IT support', style: GoogleFonts.lato())
                            ],
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                        Container(
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                          child: Row(
                            children: <Widget>[
                              Icon(LineIcons.lightningBolt,),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                              Text('Electrician', style: GoogleFonts.lato())
                            ],
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                        Container(
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                          child: Row(
                            children: <Widget>[
                              Icon(LineIcons.brain,),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                              Text('Psychologist', style: GoogleFonts.lato())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                  Container(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Learn Vietnamese',
                          style: GoogleFonts.lato(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(0, 99, 99, 30)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.VIETNAMESE_LEARN);
                          },
                          child: Text('See more',
                              style: GoogleFonts.lato(
                                  color: Color.fromRGBO(30, 193, 194, 30))),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            width: SizeConfig.blockSizeHorizontal * 95,
                            height: SizeConfig.blockSizeVertical * 22,
                            image: AssetImage(
                                'assets/images/utilities_banner_2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.grey.withOpacity(0),
                                    Colors.black,
                                  ],
                                  stops: [
                                    0.0,
                                    2.0
                                  ])),
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1,
                              right: SizeConfig.blockSizeHorizontal * 1,
                              bottom: SizeConfig.blockSizeHorizontal * 2),
                          alignment: Alignment.bottomLeft,
                          width: SizeConfig.blockSizeHorizontal * 95,
                          height: SizeConfig.blockSizeVertical * 22,
                          child: Container(
                            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Learn Vietnamese',
                                  style: GoogleFonts.lato(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Container(
                                  width: SizeConfig.blockSizeVertical * 30,
                                  child: Text(
                                    'Learn Vietnamese through vocabulary and sentence to improve your Vietnamese skill',
                                    style: GoogleFonts.lato(color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1,),
                  Container(
                    height: SizeConfig.blockSizeVertical * 19,
                    padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2.5, right: SizeConfig.blockSizeHorizontal * 2),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 15,
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Greetings', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),),
                              Image(
                                width: SizeConfig.blockSizeHorizontal * 15,
                                height: SizeConfig.blockSizeVertical * 14,
                                image: AssetImage('assets/images/demo_lesson.png'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 15,
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Greetings', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),),
                              Image(
                                width: SizeConfig.blockSizeHorizontal * 15,
                                height: SizeConfig.blockSizeVertical * 14,
                                image: AssetImage('assets/images/demo_lesson.png'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 15,
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Greetings', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),),
                              Image(
                                width: SizeConfig.blockSizeHorizontal * 15,
                                height: SizeConfig.blockSizeVertical * 14,
                                image: AssetImage('assets/images/demo_lesson.png'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 30,
                          height: SizeConfig.blockSizeVertical * 15,
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26.withOpacity(0.05),
                                    offset: Offset(0.0, 6.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.10)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Greetings', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),),
                              Image(
                                width: SizeConfig.blockSizeHorizontal * 15,
                                height: SizeConfig.blockSizeVertical * 14,
                                image: AssetImage('assets/images/demo_lesson.png'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // InkWell(
            //   onTap: (){
            //     Navigator.pushNamed(context, RouteName.SPECIALISTS);
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(10.0),
            //         boxShadow: [
            //           BoxShadow(
            //               color: Colors.black26.withOpacity(0.1),
            //               offset: Offset(0.0, 6.0),
            //               blurRadius: 10.0,
            //               spreadRadius: 0.10)
            //         ]),
            //     width: SizeConfig.blockSizeHorizontal * 85,
            //     height: SizeConfig.blockSizeVertical * 20,
            //     child: Row(
            //       children: <Widget>[
            //         Image(
            //             width: SizeConfig.blockSizeHorizontal * 25,
            //             height: SizeConfig.blockSizeVertical * 15,
            //             image: AssetImage('assets/images/expert_logo.png')),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text('Find your specialist', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),),
            //             Container(
            //               width: SizeConfig.blockSizeVertical * 25,
            //               child: Text(
            //                   'Have an appointment with specialists, they will help you to solve your problems.',
            //                   style: GoogleFonts.lato(),
            //               ),
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: SizeConfig.blockSizeVertical * 3,
            // ),
            // InkWell(
            //   onTap: () {
            //     Navigator.pushNamed(context, '/vietnameseLearns');
            //   },
            //   child: Container(
            //     width: SizeConfig.blockSizeHorizontal * 85,
            //     height: SizeConfig.blockSizeVertical * 20,
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(10.0),
            //         boxShadow: [
            //           BoxShadow(
            //               color: Colors.black26.withOpacity(0.1),
            //               offset: Offset(0.0, 6.0),
            //               blurRadius: 10.0,
            //               spreadRadius: 0.10)
            //         ]),
            //     child: Row(
            //       children: <Widget>[
            //         SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text('Learn Vietnamese', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),),
            //             Container(
            //               width: SizeConfig.blockSizeVertical * 22,
            //               child: Text(
            //                   'Learn Vietnamese through vocabulary and sentence', style: GoogleFonts.lato(),),
            //             ),
            //           ],
            //         ),
            //         Image(
            //             width: SizeConfig.blockSizeHorizontal * 25,
            //             height: SizeConfig.blockSizeVertical * 25,
            //             image: AssetImage('assets/images/vietnamese_logo.png')),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text("Recent problems", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w500, color: Color.fromRGBO(0, 99, 99, 30)),),
            //       Text('See more', style: GoogleFonts.lato(color: Color.fromRGBO(30, 193, 194, 30)))
            //     ],
            //   ),
            // ),
            // Container(
            //   height: SizeConfig.blockSizeVertical * 5,
            //   padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: <Widget>[
            //       SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            //       Container(
            //         //width: SizeConfig.blockSizeHorizontal * 30,
            //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26.withOpacity(0.05),
            //                   offset: Offset(0.0, 6.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10)
            //             ]),
            //         child: Row(
            //           children: <Widget>[
            //             Icon(LineIcons.balanceScale,),
            //             SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
            //             Text('Lawyer', style: GoogleFonts.lato())
            //           ],
            //         ),
            //       ),
            //       SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            //       Container(
            //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26.withOpacity(0.05),
            //                   offset: Offset(0.0, 6.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10)
            //             ]),
            //         child: Row(
            //           children: <Widget>[
            //             Icon(LineIcons.laptop,),
            //             SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
            //             Text('IT support', style: GoogleFonts.lato())
            //           ],
            //         ),
            //       ),
            //       SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            //       Container(
            //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26.withOpacity(0.05),
            //                   offset: Offset(0.0, 6.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10)
            //             ]),
            //         child: Row(
            //           children: <Widget>[
            //             Icon(LineIcons.lightningBolt,),
            //             SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
            //             Text('Electrician', style: GoogleFonts.lato())
            //           ],
            //         ),
            //       ),
            //       SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            //       Container(
            //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26.withOpacity(0.05),
            //                   offset: Offset(0.0, 6.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10)
            //             ]),
            //         child: Row(
            //           children: <Widget>[
            //             Icon(LineIcons.brain,),
            //             SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
            //             Text('Psychologist', style: GoogleFonts.lato())
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Text("Recent lessons", style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w500, color: Color.fromRGBO(0, 99, 99, 30)),),
            //       Text('See more', style: GoogleFonts.lato(color: Color.fromRGBO(30, 193, 194, 30)))
            //     ],
            //   ),
            // ),
            // Container(
            //   height: SizeConfig.blockSizeVertical * 19,
            //   padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal * 2),
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: <Widget>[
            //       Container(
            //         width: SizeConfig.blockSizeHorizontal * 30,
            //         height: SizeConfig.blockSizeVertical * 15,
            //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26.withOpacity(0.05),
            //                   offset: Offset(0.0, 6.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10)
            //             ]),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text('Greetings', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),),
            //             Image(
            //               width: SizeConfig.blockSizeHorizontal * 15,
            //               height: SizeConfig.blockSizeVertical * 14,
            //               image: AssetImage('assets/images/demo_lesson.png'),
            //             )
            //           ],
            //         ),
            //       ),
            //       SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            //       Container(
            //         width: SizeConfig.blockSizeHorizontal * 30,
            //         height: SizeConfig.blockSizeVertical * 15,
            //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26.withOpacity(0.05),
            //                   offset: Offset(0.0, 6.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10)
            //             ]),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text('Greetings', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),),
            //             Image(
            //               width: SizeConfig.blockSizeHorizontal * 15,
            //               height: SizeConfig.blockSizeVertical * 14,
            //               image: AssetImage('assets/images/demo_lesson.png'),
            //             )
            //           ],
            //         ),
            //       ),
            //       SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            //       Container(
            //         width: SizeConfig.blockSizeHorizontal * 30,
            //         height: SizeConfig.blockSizeVertical * 15,
            //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26.withOpacity(0.05),
            //                   offset: Offset(0.0, 6.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10)
            //             ]),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text('Greetings', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),),
            //             Image(
            //               width: SizeConfig.blockSizeHorizontal * 15,
            //               height: SizeConfig.blockSizeVertical * 14,
            //               image: AssetImage('assets/images/demo_lesson.png'),
            //             )
            //           ],
            //         ),
            //       ),
            //       SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
            //       Container(
            //         width: SizeConfig.blockSizeHorizontal * 30,
            //         height: SizeConfig.blockSizeVertical * 15,
            //         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                   color: Colors.black26.withOpacity(0.05),
            //                   offset: Offset(0.0, 6.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10)
            //             ]),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text('Greetings', style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),),
            //             Image(
            //               width: SizeConfig.blockSizeHorizontal * 15,
            //               height: SizeConfig.blockSizeVertical * 14,
            //               image: AssetImage('assets/images/demo_lesson.png'),
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //
            // )
          ],
        ),
      ),
    );
  }
}
