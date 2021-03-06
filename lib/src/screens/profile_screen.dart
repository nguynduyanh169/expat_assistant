import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/profile_cubit.dart';
import 'package:expat_assistant/src/states/profile_state.dart';
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  HiveUtils _hiveUtils = HiveUtils();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Map<dynamic, dynamic> loginResponse =
        _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
    String fullname = loginResponse['fullname'].toString();
    String avatar = loginResponse['avatar'].toString();
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child:
          BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
        if (state.status.isLoggingOut) {
          CustomLoadingDialog.loadingDialog(
              context: context, message: 'Logging out');
        } else if (state.status.isLogoutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.LOGIN, (Route<dynamic> route) => false);
        } else if (state.status.isLogoutFailed) {
          print(state.message);
        }
      }, builder: (context, state) {
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
            //toolbarHeight: SizeConfig.blockSizeVertical * 10,
            automaticallyImplyLeading: false,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Profile',
              style: GoogleFonts.lato(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          body: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 4,
                right: SizeConfig.blockSizeHorizontal * 4),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 4,
                ),
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: SizeConfig.blockSizeHorizontal * 13,
                    child: ClipOval(
                      child: ExtendedImage.network(
                        avatar,
                        fit: BoxFit.cover,
                        width: SizeConfig.blockSizeHorizontal * 26,
                        height: SizeConfig.blockSizeHorizontal * 33,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Center(
                  child: Text(
                    fullname,
                    style: GoogleFonts.lato(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3.75,
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
                      EventBusUtils.getInstance()
                          .on<ChangedProfile>()
                          .listen((event) {
                        setState(() {
                          if (event.changed == true) {
                            fullname = loginResponse['fullname'].toString();
                            avatar = loginResponse['avatar'].toString();
                          }
                        });
                      });
                      Navigator.pushNamed(context, RouteName.EDIT_PROFILE);
                    },
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
                    onTap: () {},
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
                      'Payments History',
                      style: GoogleFonts.lato(),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, RouteName.CHANGE_PASSWORD),
                  child: Container(
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
                              content: Text(
                                  'You are about to sign out of application',
                                  style: GoogleFonts.lato(
                                    color: Colors.black54,
                                  )),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text('CANCEL',
                                        style: GoogleFonts.lato(
                                            color: AppColors.MAIN_COLOR,
                                            fontWeight: FontWeight.w700))),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Text('SIGN OUT',
                                        style: GoogleFonts.lato(
                                            color: AppColors.MAIN_COLOR,
                                            fontWeight: FontWeight.w700)))
                              ],
                            );
                          }).then((value) {
                        if (value == true) {
                          BlocProvider.of<ProfileCubit>(context).logout();
                        } else {
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
      }),
    );
  }

  @override
  void updateKeepAlive() {
    // ignore: todo
    // TODO: implement updateKeepAlive
  }

  @override
  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
