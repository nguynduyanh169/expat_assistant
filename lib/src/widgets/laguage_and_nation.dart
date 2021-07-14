import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

// ignore: must_be_immutable
class LanguageAndNation extends StatefulWidget {
  Function buttonAction;

  LanguageAndNation({this.buttonAction});
  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
    Animal(id: 11, name: "Cat"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "Rabbit"),
    Animal(id: 14, name: "Mouse"),
    Animal(id: 15, name: "Dog"),
    Animal(id: 16, name: "Zebra"),
    Animal(id: 17, name: "Cow"),
    Animal(id: 18, name: "Frog"),
    Animal(id: 19, name: "Blue Jay"),
    Animal(id: 20, name: "Moose"),
    Animal(id: 21, name: "Gecko"),
    Animal(id: 22, name: "Kangaroo"),
    Animal(id: 23, name: "Shark"),
    Animal(id: 24, name: "Crocodile"),
    Animal(id: 25, name: "Owl"),
    Animal(id: 26, name: "Dragonfly"),
    Animal(id: 27, name: "Dolphin"),
  ];

  @override
  _LanguageAndNationState createState() => _LanguageAndNationState();
}

class _LanguageAndNationState extends State<LanguageAndNation> {
  List<Animal> _selectedAnimals = [];

  final _items = LanguageAndNation._animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();

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
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                MultiSelectBottomSheetField(
                  initialChildSize: 0.4,
                  listType: MultiSelectListType.CHIP,
                  searchable: true,
                  buttonText: Text(
                    "Select Your Languages",
                    style: GoogleFonts.lato(),
                  ),
                  title: Text("Languages", style: GoogleFonts.lato()),
                  items: _items,
                  onConfirm: (values) {
                    _selectedAnimals = values;
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    textStyle: GoogleFonts.lato(),
                    onTap: (value) {
                      setState(() {
                        _selectedAnimals.remove(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                MultiSelectBottomSheetField(
                  initialChildSize: 0.4,
                  listType: MultiSelectListType.CHIP,
                  searchable: true,
                  buttonText: Text(
                    "Select Your Nation",
                    style: GoogleFonts.lato(),
                  ),
                  title: Text("Nation", style: GoogleFonts.lato()),
                  items: _items,
                  onConfirm: (values) {
                    _selectedAnimals = values;
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    textStyle: GoogleFonts.lato(),
                    onTap: (value) {
                      setState(() {
                        _selectedAnimals.remove(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
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
                onPressed: widget.buttonAction),
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

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}
