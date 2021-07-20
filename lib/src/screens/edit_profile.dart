import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:select_form_field/select_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List _myActivities = [];
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
      'icon': Icon(Icons.stop),
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
      'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
      'enable': false,
      'icon': Icon(Icons.grade),
    },
  ];

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.lato(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(RouteName.HOME_PAGE));
              },
              icon: Icon(CupertinoIcons.check_mark)),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
      ),
      
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            InkWell(
              onTap: () {
                
              },
              child: CircleAvatar(
                radius: SizeConfig.blockSizeHorizontal * 13,
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/images/profile.png'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            InkWell(
              onTap: () {
                getImage();
              },
              child: Text(
                'Change Profile Picture',
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.MAIN_COLOR),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Email',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            TextFormField(
              style: GoogleFonts.lato(),
              initialValue: 'anhnd16091998@gmail.com',
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: GoogleFonts.lato(),
                hoverColor: Color.fromRGBO(30, 193, 194, 30),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Fullname',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            TextFormField(
              style: GoogleFonts.lato(),
              initialValue: 'Ho Quang Bao',
              decoration: InputDecoration(
                hintText: 'Enter your fullname',
                hintStyle: GoogleFonts.lato(),
                hoverColor: Color.fromRGBO(30, 193, 194, 30),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Phone Number',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            TextFormField(
              style: GoogleFonts.lato(),
              initialValue: '0334155353',
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                hintStyle: GoogleFonts.lato(),
                hoverColor: Color.fromRGBO(30, 193, 194, 30),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
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
            MultiSelectFormField(
              autovalidate: false,
              chipBackGroundColor: Colors.red,
              chipLabelStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
              dialogTextStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
              checkBoxActiveColor: Colors.red,
              checkBoxCheckColor: Colors.green,
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text(
                "Select your languages",
                style: GoogleFonts.lato(fontSize: 16),
              ),
              dataSource: [
                {
                  "display": "Running",
                  "value": "Running",
                },
                {
                  "display": "Climbing",
                  "value": "Climbing",
                },
                {
                  "display": "Walking",
                  "value": "Walking",
                },
              ],
              textField: 'display',
              valueField: 'value',
              okButtonLabel: 'OK',
              cancelButtonLabel: 'CANCEL',
              hintWidget: Text(
                'Please choose one or more',
                style: GoogleFonts.lato(),
              ),
              initialValue: _myActivities,
              onSaved: (value) {},
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Nation',
                style:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SelectFormField(
              type: SelectFormFieldType.dropdown, // or can be dialog
              initialValue: 'circle',
              labelText: 'Nation',
              items: _items,
              onChanged: (val) => print(val),
              onSaved: (val) => print(val),
            )
          ],
        ),
      ),
    );
  }
}
