import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/utils/vn_learn_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/radio_list_tile/gf_radio_list_tile.dart';
import 'package:getwidget/types/gf_radio_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweetsheet/sweetsheet.dart';

// ignore: must_be_immutable
class VocabularyPracticeWriting extends StatefulWidget {
  VocabularyLocal vocabulary;
  List<VocabularyLocal> vocabularyList;
  Function openListening;

  VocabularyPracticeWriting(
      {@required this.vocabulary,
      @required this.openListening,
      @required this.vocabularyList});

  @override
  _VocabularyPracticeWritingState createState() =>
      _VocabularyPracticeWritingState(
          vocabulary, openListening, vocabularyList);
}

class _VocabularyPracticeWritingState extends State<VocabularyPracticeWriting> {
  final SweetSheet _sweetSheet = SweetSheet();
  VocabularyLocal vocabulary;
  List<VocabularyLocal> vocabularyList;
  Function openListening;
  int groupValue = 0;
  List<VocabularyLocal> vocabularyOptions = [];

  _VocabularyPracticeWritingState(
      this.vocabulary, this.openListening, this.vocabularyList);

  @override
  void initState() {
    vocabularyOptions =
        VNLearnUtils().getQuizOption(vocabularyList, vocabulary);
    print(vocabularyOptions[0].description);
    super.initState();
  }

  void checkAnswer(String learnerAnswer, String english, BuildContext context) {
    if (learnerAnswer.toLowerCase().trim() == english.toLowerCase().trim()) {
      _sweetSheet.show(
        isDismissible: false,
        context: context,
        title: Text(
          "Correct",
          style: GoogleFonts.lato(),
        ),
        description: Text(
            '${vocabulary.vocabulary.toUpperCase()}' +
                '\nEnglish meaning: ${vocabulary.description}',
            style: GoogleFonts.lato()),
        color: SweetSheetColor.SUCCESS,
        icon: CupertinoIcons.check_mark_circled_solid,
        positive: SweetSheetAction(
          onPressed: () {
            openListening();
            Navigator.of(context).pop();
          },
          title: 'NEXT',
          icon: CupertinoIcons.arrow_right_circle_fill,
        ),
      );
    } else {
      _sweetSheet.show(
        isDismissible: false,
        context: context,
        title: Text("Incorrect", style: GoogleFonts.lato()),
        description: Text(
            '${vocabulary.vocabulary.toUpperCase()}' +
                '\nEnglish meaning: ${vocabulary.description}',
            style: GoogleFonts.lato()),
        color: SweetSheetColor.DANGER,
        icon: CupertinoIcons.xmark_circle_fill,
        positive: SweetSheetAction(
          onPressed: () {
            //_textEditingController.clear();
            Navigator.of(context).pop();
          },
          title: 'DO AGAIN',
          icon: CupertinoIcons.arrow_counterclockwise,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Choose the correct translation',
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Text(
            widget.vocabulary.vocabulary,
            style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 40,
            child: ListView.separated(
                itemBuilder: (context, index) => Container(
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
                      child: GFRadioListTile(
                        title: Text(
                          vocabularyOptions[index]
                              .description
                              .toUpperCase()
                              .trim(),
                          style: GoogleFonts.lato(fontSize: 15),
                        ),
                        size: 25,
                        activeBorderColor: AppColors.MAIN_COLOR,
                        focusColor: AppColors.MAIN_COLOR,
                        type: GFRadioType.basic,
                        inactiveBorderColor: Colors.black38,
                        value: vocabularyOptions[index].id,
                        groupValue: groupValue,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            groupValue = value;
                          });
                        },
                        
                        inactiveIcon: null,
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    ),
                itemCount: vocabularyOptions.length),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 21,
          ),
          Center(
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 85,
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.MAIN_COLOR),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          GoogleFonts.lato(fontSize: 17))),
                  //: Color.fromRGBO(30, 193, 194, 30),
                  child: Text("Check"),
                  onPressed: () {
                    print(groupValue);
                    checkAnswer(vocabularyOptions.firstWhere((element) => element.id == groupValue, orElse: () => null).description,
                        vocabulary.description, context);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
