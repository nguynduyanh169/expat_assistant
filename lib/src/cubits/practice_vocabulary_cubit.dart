import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/states/practice_vocabulary_state.dart';

class PracticeVocabularyCubit extends Cubit<PracticeVocabularyState> {
  PracticeVocabularyCubit() : super(const PracticeVocabularyState());

  Future<void> practiceWriting(int index, int lessonLength) async {
    if(index > lessonLength - 1){
      emit(state.copyWith(status: PracticeVocabularyStatus.practiceDone, lessonLenght: lessonLength));
    }else {
      emit(state.copyWith(
          index: index, status: PracticeVocabularyStatus.practiceWriting));
    }
  }

  Future<void> practiceListening(int index) async {
    emit(state.copyWith(
        index: index, status: PracticeVocabularyStatus.practiceListening));
  }

  Future<void> practiceSpeaking(int index) async {
    emit(state.copyWith(
        index: index, status: PracticeVocabularyStatus.practiceSpeaking));
  }

}
