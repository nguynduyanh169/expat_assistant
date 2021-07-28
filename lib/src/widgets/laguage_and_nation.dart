import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:textfield_tags/textfield_tags.dart';

// ignore: must_be_immutable
class LanguageAndNation extends StatefulWidget {
  Function buttonAction;
  Expat expat;

  LanguageAndNation({this.buttonAction, this.expat});
  static List<Nation> nations = [
    Nation(nationId: 1, nationName: 'United State'),
    Nation(nationId: 2, nationName: 'Korea'),
    Nation(nationId: 3, nationName: 'Japanese'),
    Nation(nationId: 4, nationName: 'Chinese'),
    Nation(nationId: 5, nationName: 'Italy'),
  ];

  static List<Language> languages = [
    Language(languageId: 1, languageName: "English"),
    Language(languageId: 2, languageName: "Japanese"),
    Language(languageId: 3, languageName: "Chinese"),
    Language(languageId: 4, languageName: "Korean"),
    Language(languageId: 5, languageName: "French"),
  ];
  @override
  _LanguageAndNationState createState() => _LanguageAndNationState();
}

class _LanguageAndNationState extends State<LanguageAndNation> {
  Nation selectedNation;
  List<Language> _selectedLanguages = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 2,
          right: SizeConfig.safeBlockHorizontal * 2),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Text(
            'Language and nation',
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 70,
            child: Text(
              'Second, Please add your language and nation',
              style: GoogleFonts.lato(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Languages',
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                MultiSelectBottomSheetField<Language>(
                  initialChildSize: 0.4,
                  listType: MultiSelectListType.CHIP,
                  searchable: true,
                  buttonIcon: Icon(Icons.arrow_drop_down),
                  buttonText: Text(
                    "Choose your languages",
                    style:
                        GoogleFonts.lato(color: Colors.black54, fontSize: 16),
                  ),
                  title: Text("Language", style: GoogleFonts.lato()),
                  items: LanguageAndNation.languages
                      .map((lang) =>
                          MultiSelectItem<Language>(lang, lang.languageName))
                      .toList(),
                  onConfirm: (values) {
                    setState(() {
                      _selectedLanguages = values;
                    });
                    _multiSelectKey.currentState.validate();
                  },
                  validator: (values) {
                    if (_selectedLanguages == null ||
                        _selectedLanguages.isEmpty) {
                      return "Please choosse at lease one language!";
                    } else {
                      return null;
                    }
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    textStyle: GoogleFonts.lato(),
                    onTap: (value) {
                      setState(() {
                        _selectedLanguages.remove(value);
                      });
                      _multiSelectKey.currentState.validate();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Nation',
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          DropdownButtonFormField(
              decoration: InputDecoration(
                hintText: 'Choose your nation',
                hintStyle: GoogleFonts.lato(),
                hoverColor: Color.fromRGBO(30, 193, 194, 30),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              onChanged: (value) {
                selectedNation = value;
              },
              items: LanguageAndNation.nations
                  .map((nation) => DropdownMenuItem<Nation>(
                      value: nation,
                      child: Text(
                        nation.nationName,
                        style: GoogleFonts.lato(),
                      )))
                  .toList()),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 85,
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.MAIN_COLOR),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.lato(fontSize: 17, color: Colors.white))),
                child: Text(
                  "Next",
                  style: GoogleFonts.lato(fontSize: 17, color: Colors.white),
                ),
                onPressed: () {
                  if (selectedNation != null && _selectedLanguages.isNotEmpty) {
                    widget.expat.languages = _selectedLanguages;
                    widget.expat.nationEntity = selectedNation.nationName;
                    widget.buttonAction();
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Choose Language and Nation',
                              style: GoogleFonts.lato(),
                            ),
                            content: Text(
                                'Seem you have not choose any language and nation',
                                style: GoogleFonts.lato()),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Got It',
                                      style: GoogleFonts.lato(
                                          color: AppColors.MAIN_COLOR,
                                          fontWeight: FontWeight.w700))),
                            ],
                          );
                        });
                  }
                }),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account?",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600, color: Colors.black54),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600, color: Colors.green),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Nation {
  final int nationId;
  final String nationName;

  Nation({
    this.nationId,
    this.nationName,
  });
}
