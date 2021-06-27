import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/practice_conversation_cubit.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/screens/finish_screen.dart';
import 'package:expat_assistant/src/states/practice_conversation_state.dart';
import 'package:expat_assistant/src/widgets/conversation_practice_listening.dart';
import 'package:expat_assistant/src/widgets/conversation_practice_speaking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PracticeConversationScreen extends StatefulWidget {
  _PracticeConversationState createState() => _PracticeConversationState();
}

class _PracticeConversationState extends State<PracticeConversationScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args = ModalRoute.of(context).settings.arguments
        as PracticeConversationScreenArguments;
    return BlocProvider(
      create: (context) => PracticeConversationCubit()
        ..practiceListening(index, args.conversationList.length),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                BlocBuilder<PracticeConversationCubit,
                    PracticeConversationState>(
                  buildWhen: (previous, current) {
                    return previous.index != current.index;
                  },
                  builder: (context, state) {
                    if (state.status.isPracticeListening) {
                      index = state.index;
                    }
                    return Container(
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
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
                                totalSteps: args.conversationList.length,
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
                            '$index/${args.conversationList.length}',
                            style: GoogleFonts.lato(),
                          )
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                BlocConsumer<PracticeConversationCubit,
                    PracticeConversationState>(builder: (context, state) {
                  if (state.status.isPracticeListening) {
                    index = state.index;
                    return ConversationPracticeListening(
                      conversation: args.conversationList[index],
                      openSpeaking: () {
                        BlocProvider.of<PracticeConversationCubit>(context)
                            .practiceSpeaking(index);
                      },
                    );
                  } else {
                    index = state.index;
                    return ConversationPracticeSpeaking(
                        conversation: args.conversationList[index],
                        openListening: () {
                          BlocProvider.of<PracticeConversationCubit>(context)
                              .practiceListening(
                                  index + 1, args.conversationList.length);
                        });
                  }
                }, listener: (context, state) {
                  if (state.status.isPracticeDone) {
                    Navigator.pushNamed(context, RouteName.FINISH_CONVERSATION,
                        arguments: FinishScreenForConversationArugments(
                            args.conversationList.length));
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PracticeConversationScreenArguments {
  final List<ConversationLocal> conversationList;

  PracticeConversationScreenArguments(this.conversationList);
}
