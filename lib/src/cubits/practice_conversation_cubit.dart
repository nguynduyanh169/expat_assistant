import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/states/practice_conversation_state.dart';

class PracticeConversationCubit extends Cubit<PracticeConversationState> {
  PracticeConversationCubit() : super(const PracticeConversationState());

  Future<void> practiceListening(int index, int lessonLenght) async {
    if (index > lessonLenght - 1) {
      emit(state.copyWith(
          status: PracticeConversationStatus.practiceDone,
          lessonLenght: lessonLenght));
    } else {
      emit(state.copyWith(
          index: index, status: PracticeConversationStatus.practiceListening));
    }
  }

  Future<void> practiceSpeaking(int index) async {
    emit(state.copyWith(
        index: index, status: PracticeConversationStatus.practiceSpeaking));
  }

}
