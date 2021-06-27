import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/states/conversation_practice_speaking_state.dart';

class ConversationPracticeSpeakingCubit
    extends Cubit<ConversationPracticeSpeakingState> {
  ConversationPracticeSpeakingCubit()
      : super(const ConversationPracticeSpeakingState(
            status: ConversationPracticeSpeakingStatus.init));
}
