import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Feedbacks",
          style: GoogleFonts.lato(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(RouteName.HOME_PAGE));
              },
              icon: Icon(CupertinoIcons.home)),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 10,
                right: SizeConfig.blockSizeHorizontal * 10,
                top: SizeConfig.blockSizeVertical * 1.75,
                bottom: SizeConfig.blockSizeVertical * 1.75),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26.withOpacity(0.2),
                      offset: Offset(0.0, 6.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.10)
                ]),
            height: SizeConfig.blockSizeVertical * 10,
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 70,
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.MAIN_COLOR),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.lato(fontSize: 17))),
                child: Text("Send Feedback"),
                onPressed: () => print('ok'),
              ),
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
              Container(
                width: SizeConfig.blockSizeHorizontal * 87,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rate Your Experience',
                      style: GoogleFonts.lato(
                          fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    Text('Are you satified with the service of Dr. Le Quang Bao',
                        style: GoogleFonts.lato(
                            fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Divider(
                color: Colors.grey,
              ),
              Text(
                'Tell us what can be improved!',
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 5,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    InputChip(
                      label: Text(
                        'Sound Quality',
                        style: GoogleFonts.lato(),
                      ),
                      onSelected: (bool value) {},
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    InputChip(
                      label: Text(
                        'Sound Quality',
                        style: GoogleFonts.lato(),
                      ),
                      onSelected: (bool value) {},
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    InputChip(
                      label: Text(
                        'Sound Quality',
                        style: GoogleFonts.lato(),
                      ),
                      onSelected: (bool value) {},
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    InputChip(
                      label: Text(
                        'Sound Quality',
                        style: GoogleFonts.lato(),
                      ),
                      onSelected: (bool value) {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              TextFormField(
                  maxLines: 13,
                  decoration: InputDecoration(
                    hintText: 'Enter your comment ...',
                    hintStyle: GoogleFonts.lato(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightGreen)),
                    border: OutlineInputBorder(borderSide: BorderSide(),),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
