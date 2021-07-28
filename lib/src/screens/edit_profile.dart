import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/edit_profile_cubit.dart';
import 'package:expat_assistant/src/models/expat.dart';
import 'package:expat_assistant/src/repositories/user_repository.dart';
import 'package:expat_assistant/src/states/edit_profile_state.dart';
import 'package:expat_assistant/src/utils/event_bus_utils.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Profile profile;
  NationEntity selectedNation;
  File imageFile;
  List<Language> _selectedLanguages = [];
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  static List<NationEntity> nations = [
    NationEntity(nationId: 1, nationName: 'United State'),
    NationEntity(nationId: 2, nationName: 'Korea'),
    NationEntity(nationId: 3, nationName: 'Japanese'),
    NationEntity(nationId: 4, nationName: 'Chinese'),
    NationEntity(nationId: 5, nationName: 'Italy'),
  ];

  static List<Language> languages = [
    Language(languageId: 1, languageName: "English"),
    Language(languageId: 2, languageName: "Japanese"),
    Language(languageId: 3, languageName: "Chinese"),
    Language(languageId: 4, languageName: "Korean"),
    Language(languageId: 5, languageName: "French"),
  ];

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile.path);
      setState(() {
        imageFile = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(UserRepository())..getProfile(),
      child: Scaffold(
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
            BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      profile.expat.fullname = _fullNameController.text.trim();
                      profile.expat.phone = _phoneController.text.trim();
                      profile.expat.nationEntity = selectedNation;
                      profile.languages.clear();
                      profile.languages = _selectedLanguages;
                      print(profile.languages.length);
                      BlocProvider.of<EditProfileCubit>(context)
                          .editProfile(imageFile, profile);
                    },
                    icon: Icon(CupertinoIcons.check_mark));
              },
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
        body: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state.status.isUpdatingProfile) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Updating...');
            } else if (state.status.isUpdatedProfile) {
              EventBusUtils.getInstance().fire(ChangedProfile(true));
              Navigator.pop(context);
              Navigator.popUntil(
                  context, ModalRoute.withName(RouteName.HOME_PAGE));
            } else if (state.status.isUpdateProfileFailed) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state.status.isLoadingProfile) {
              return LoadingView(message: 'Loading...');
            } else {
              if (state.status.isLoadedProfile) {
                profile = state.expatProfile;
                _selectedLanguages = state.expatProfile.languages;
                selectedNation = state.expatProfile.expat.nationEntity;
                _phoneController.text = profile.expat.phone;
                _fullNameController.text = profile.expat.fullname;
              }
              return Container(
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
                      onTap: () {},
                      child: CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 13,
                        child: ClipOval(
                          child: imageFile != null
                              ? ExtendedImage.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                  width: SizeConfig.blockSizeHorizontal * 26,
                                  height: SizeConfig.blockSizeHorizontal * 33,
                                )
                              : ExtendedImage.network(
                                  profile.expat.avatarLink,
                                  fit: BoxFit.cover,
                                  width: SizeConfig.blockSizeHorizontal * 26,
                                  height: SizeConfig.blockSizeHorizontal * 33,
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
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.MAIN_COLOR),
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
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.lato(),
                      initialValue: profile.expat.email,
                      readOnly: true,
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
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    TextFormField(
                      controller: _fullNameController,
                      style: GoogleFonts.lato(),
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
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    TextFormField(
                      controller: _phoneController,
                      style: GoogleFonts.lato(),
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
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          MultiSelectBottomSheetField<Language>(
                            initialValue: _selectedLanguages,
                            initialChildSize: 0.4,
                            listType: MultiSelectListType.CHIP,
                            searchable: true,
                            buttonIcon: Icon(Icons.arrow_drop_down),
                            buttonText: Text(
                              "Choose your languages",
                              style: GoogleFonts.lato(
                                  color: Colors.black54, fontSize: 16),
                            ),
                            title: Text("Language", style: GoogleFonts.lato()),
                            items: languages
                                .map((lang) => MultiSelectItem<Language>(
                                    lang, lang.languageName))
                                .toList(),
                            onConfirm: (values) {
                              _selectedLanguages = values;
                              print('Choose lenght ' +
                                  _selectedLanguages.length.toString());
                            },
                            chipDisplay: MultiSelectChipDisplay(
                              items: _selectedLanguages
                                  .map(
                                      (e) => MultiSelectItem(e, e.languageName))
                                  .toList(),
                              textStyle: GoogleFonts.lato(),
                              onTap: (value) {
                                setState(() {
                                  _selectedLanguages.remove(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nation',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    DropdownButtonFormField(
                        isExpanded: true,
                        value: selectedNation,
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
                        items: nations
                            .map((nation) => DropdownMenuItem<NationEntity>(
                                value: nation,
                                child: Text(
                                  nation.nationName,
                                  style: GoogleFonts.lato(),
                                )))
                            .toList()),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
