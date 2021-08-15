import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/vn_learn_cubit.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/repositories/conversation_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/repositories/vocabulary_repository.dart';
import 'package:expat_assistant/src/screens/conversation_details_screen.dart';
import 'package:expat_assistant/src/screens/vocabulary_details_screen.dart';
import 'package:expat_assistant/src/states/vn_learn_state.dart';
import 'package:expat_assistant/src/widgets/error.dart';
import 'package:expat_assistant/src/widgets/lesson_card.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:expat_assistant/src/widgets/not_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class VNlearnScreen extends StatefulWidget {
  _VNlearnScreenState createState() => _VNlearnScreenState();
}

class _VNlearnScreenState extends State<VNlearnScreen> {
  List<LessonLocal> _lessons;
  FocusNode _focus = new FocusNode();
  bool emptyLessons = false;

  void _onFocusChange() {
    SystemChrome.setEnabledSystemUIOverlays([]); // hide status + action buttons
  }

  @override
  Widget build(BuildContext context) {
    _focus.addListener(_onFocusChange);
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Learn Vietnamese',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.white),
        ),
        actions: [
          InkWell(
            child: Icon(CupertinoIcons.home),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => VNlearnCubit(
            TopicRepository(), ConversationRepository(), VocabularyRepository())
          ..getAllTopic(),
        child: BlocConsumer<VNlearnCubit, VNlearnState>(
          listener: (context, state) {
            if (state.status.isDownloadingVocabulary) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Downloading...');
            } else if (state.status.isDownloadVocabularySuccess) {
              Navigator.pop(context);
            } else if (state.status.isDownloadingConversation) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Downloading...');
            } else if (state.status.isDownloadConversationSuccess) {
              Navigator.pop(context);
            } else if (state.status.isSearchFailed) {
              emptyLessons = true;
            } else if (state.status.isSearchSuccess) {
              emptyLessons = false;
            }
          },
          builder: (context, state) {
            if (state.status.isLoadFailed) {
              return DisplayError(
                  message: 'Something went wrongs',
                  reload: () {
                    BlocProvider.of<VNlearnCubit>(context).getAllTopic();
                  });
            } else if (state.status.isLoading) {
              return LoadingView(message: 'Loading lessons...');
            } else {
              if (state.status.isLoadSuccess) {
                _lessons = state.lessonLocalList;
              }
              if (state.status.isDownloadVocabularySuccess) {
                _lessons = state.lessonLocalList;
              }
              if (state.status.isSearchSuccess) {
                _lessons = state.lessonLocalList;
              }
              return SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 90,
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: AppColors.MAIN_COLOR, // set border color
                            width: 1.0), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // set rounded corner radius
                      ),
                      child: TextFormField(
                        focusNode: _focus,
                        onChanged: (value) {
                          BlocProvider.of<VNlearnCubit>(context)
                              .searchLesson(_lessons, value);
                        },
                        decoration: InputDecoration(
                            hintText: 'What lesson do you want to learn?',
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(
                                CupertinoIcons.search,
                                color: AppColors.MAIN_COLOR,
                              ),
                              iconSize: 30.0, onPressed: () {  },
                            ),
                            hintStyle: GoogleFonts.lato()),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                      height: SizeConfig.blockSizeVertical * 79,
                      child: emptyLessons == true
                          ? NotFound()
                          : ListView.separated(
                              itemCount: _lessons.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              itemBuilder: (context, index) => LessonCard(
                                title: _lessons[index].name,
                                description: _lessons[index].des,
                                image: _lessons[index].imageLink,
                                vocabularies: _lessons[index].vocabularies,
                                downloadConversation: () {
                                  BlocProvider.of<VNlearnCubit>(context)
                                      .downloadConversation(_lessons[index].id,
                                          _lessons[index].name);
                                },
                                downloadVocabulary: () {
                                  BlocProvider.of<VNlearnCubit>(context)
                                      .downloadVocabulary(_lessons[index].id,
                                          _lessons[index].name, context);
                                },
                                vocabularyAction: () {
                                  if (_lessons[index].vocabularies == null ||
                                      _lessons[index].vocabularies.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Please download data before starting to learn',
                                        style: GoogleFonts.lato(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      // width: SizeConfig.blockSizeHorizontal * 60,
                                      // Width of the SnackBar.
                                      padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            8.0, // Inner padding for SnackBar content.
                                      ),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.fixed,
                                    ));
                                  } else {
                                    List<VocabularyLocal> vocabularyList = [];
                                    for (var item
                                        in _lessons[index].vocabularies) {
                                      vocabularyList.add(item);
                                    }
                                    Navigator.pushNamed(
                                        context, '/vocabularyDetails',
                                        arguments:
                                            VocabularyDetailsScreenArguments(
                                                title: _lessons[index].name,
                                                vocabularyList:
                                                    vocabularyList));
                                  }
                                },
                                conversationAction: () {
                                  if (_lessons[index].conversations == null ||
                                      _lessons[index].conversations.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Please download data before starting to learn',
                                        style: GoogleFonts.lato(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      // width: SizeConfig.blockSizeHorizontal * 60,
                                      // Width of the SnackBar.
                                      padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            8.0, // Inner padding for SnackBar content.
                                      ),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.fixed,
                                    ));
                                  } else {
                                    List<ConversationLocal> conversationList =
                                        [];
                                    for (var item
                                        in _lessons[index].conversations) {
                                      conversationList.add(item);
                                    }
                                    Navigator.pushNamed(
                                        context, '/conversationDetails',
                                        arguments:
                                            ConversationDetailScreenArguments(
                                                conversationList,
                                                _lessons[index].name));
                                  }
                                },
                                conversations: _lessons[index].conversations,
                              ),
                            ),
                    ),
                  ],
                )),
              );
            }
          },
        ),
      ),
    );
  }
}
