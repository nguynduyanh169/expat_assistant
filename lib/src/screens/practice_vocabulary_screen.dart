import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/practice_vocabulary_cubit.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/screens/finish_screen.dart';
import 'package:expat_assistant/src/states/practice_vocabulary_state.dart';
import 'package:expat_assistant/src/widgets/vocabulary_practice_listening.dart';
import 'package:expat_assistant/src/widgets/vocabulary_practice_speaking.dart';
import 'package:expat_assistant/src/widgets/vocabulary_practice_writing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PracticeVocabularyScreen extends StatefulWidget {
  _PracticeVocabularyState createState() => _PracticeVocabularyState();
}

class _PracticeVocabularyState extends State<PracticeVocabularyScreen> {
  int index = 0;

  void openListening(BuildContext context) {
    BlocProvider.of<PracticeVocabularyCubit>(context).practiceListening(index);
  }

  void openSpeaking(BuildContext context) {
    BlocProvider.of<PracticeVocabularyCubit>(context).practiceSpeaking(index);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as PracticeVocabularyScreenArguments;
    return BlocProvider(
      create: (context) => PracticeVocabularyCubit()
        ..practiceWriting(index, args.vocabularyList.length),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: <Widget>[
              BlocBuilder<PracticeVocabularyCubit, PracticeVocabularyState>(
                  buildWhen: (previous, current) {
                return previous.index != current.index;
              }, builder: (context, state) {
                if (state.status.isPracticeWriting) {
                  index = state.index;
                }
                return Container(
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 6, bottom: SizeConfig.blockSizeHorizontal * 3, left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal * 3),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 65,
                        height: SizeConfig.blockSizeVertical * 1.5,
                        child: StepProgressIndicator(
                            totalSteps: args.vocabularyList.length,
                            currentStep: index,
                            size: 10,
                            padding: 0,
                            selectedColor: AppColors.MAIN_COLOR,
                            unselectedColor: Colors.grey,
                            roundedEdges: Radius.circular(10.0)),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Text(
                        '$index/${args.vocabularyList.length}',
                        style: GoogleFonts.lato(),
                      )
                    ],
                  ),
                );
              }),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 4,
              ),
              BlocConsumer<PracticeVocabularyCubit, PracticeVocabularyState>(
                  listener: (context, state) {
                if (state.status.isPracticeDone) {
                  Navigator.pushNamed(context, RouteName.FINISH,
                      arguments:
                          FinishScreenArugments(args.vocabularyList.length));
                }
              }, builder: (context, state) {
                if (state.status.isPracticeListening) {
                  index = state.index;
                  return VocabularyPracticeListening(
                    vocabulary: args.vocabularyList[index],
                    upperContext: context,
                    openSpeaking: openSpeaking,
                  );
                } else if (state.status.isPracticeWriting) {
                  index = state.index;
                  return VocabularyPracticeWriting(
                    vocabulary: args.vocabularyList[index],
                    openListening: (){
                      BlocProvider.of<PracticeVocabularyCubit>(context).practiceListening(index);
                    },
                    vocabularyList: args.vocabularyList,
                    
                  );
                } else {
                  index = state.index;
                  return VocabularyPracticeSpeaking(
                    vocabulary: args.vocabularyList[index],
                    openWriting: () {
                      BlocProvider.of<PracticeVocabularyCubit>(context)
                          .practiceWriting(
                              index + 1, args.vocabularyList.length);
                    },
                  );
                }
              })
            ],
          )),
        ),
      ),
    );
  }
}

class PracticeVocabularyScreenArguments {
  final List<VocabularyLocal> vocabularyList;

  PracticeVocabularyScreenArguments(this.vocabularyList);
}
