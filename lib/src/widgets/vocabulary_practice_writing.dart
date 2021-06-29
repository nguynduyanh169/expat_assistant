import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweetsheet/sweetsheet.dart';

// ignore: must_be_immutable
class VocabularyPracticeWriting extends StatelessWidget {
  VocabularyLocal vocabulary;
  Function openListening;
  BuildContext upperContext;
  final SweetSheet _sweetSheet = SweetSheet();
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focus = new FocusNode();

    void _onFocusChange(){
        SystemChrome.setEnabledSystemUIOverlays([]); // hide status + action buttons
    }

  VocabularyPracticeWriting(
      {@required this.vocabulary,
      @required this.openListening,
      @required this.upperContext});

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
            openListening(upperContext);
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
            _textEditingController.clear();
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
    _focus.addListener(_onFocusChange);
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
            vocabulary.vocabulary,
            style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          TextFormField(
            controller: _textEditingController,
            textInputAction: TextInputAction.go,
            focusNode: _focus,
            decoration: InputDecoration(
              hintText: 'Write english meaning here...',
              hintStyle: GoogleFonts.lato(),
              filled: true,
              fillColor: Colors.black12,
              focusColor: Color.fromRGBO(30, 193, 194, 30),
              focusedBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: new BorderSide(color: Colors.black12)),
              enabledBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: new BorderSide(color: Colors.black12)),
            ),
            minLines: 12,
            // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: null,
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
                    checkAnswer(
                        _textEditingController.text, vocabulary.description, context);
                    //openListening(upperContext);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
