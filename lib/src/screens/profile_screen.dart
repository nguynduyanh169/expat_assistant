import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color.fromRGBO(30, 193, 194, 30),
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.lato(fontSize: 22),
        ),
      ),
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            CircleAvatar(
              radius: SizeConfig.blockSizeHorizontal * 15,
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/images/profile.png'),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Text(
              'Ho Quang Bao',
              style:
                  GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
              child: ListTile(
                leading: Icon(CupertinoIcons.person_crop_circle),
                title: Text(
                  'My Account',
                  style: GoogleFonts.lato(),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
              child: ListTile(
                leading: Icon(CupertinoIcons.bell),
                title: Text(
                  'Notification',
                  style: GoogleFonts.lato(),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.WALLET);
                },
                leading: Icon(LineIcons.wallet),
                title: Text(
                  'Wallet',
                  style: GoogleFonts.lato(),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
              child: ListTile(
                leading: Icon(CupertinoIcons.lock),
                title: Text(
                  'Change Password',
                  style: GoogleFonts.lato(),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
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
              child: ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Sign out?',
                            style: GoogleFonts.lato(),
                          ),
                          content: Text('You are about to sign out',
                              style: GoogleFonts.lato()),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text('Cancel',
                                    style: GoogleFonts.lato(
                                        color:
                                            Color.fromRGBO(30, 193, 194, 30)))),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text('Sign Out',
                                    style: GoogleFonts.lato(
                                        color:
                                            Color.fromRGBO(30, 193, 194, 30))))
                          ],
                        );
                      }).then((value) {
                    if (value == true) {
                      HiveUtils _hiveUtils = HiveUtils();
                      _hiveUtils.deleteUserAuth(boxName: HiveBoxName.USER_AUTH);
                      bool checkLogout =
                          _hiveUtils.haveToken(boxName: HiveBoxName.USER_AUTH);
                      if (checkLogout == false) {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteName.LOGIN, (Route<dynamic> route) => false);
                      }else{
                        return;
                      }
                    }else{
                      return;
                    }
                  });
                },
                leading: Icon(CupertinoIcons.square_arrow_right),
                title: Text(
                  'Sign out',
                  style: GoogleFonts.lato(),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
          ],
        ),
      ),
    );
  }
}
