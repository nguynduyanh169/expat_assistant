import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/states/vocabulary_practice_speaking_state.dart';

class VocabularyPracticeSpeakingCubit
    extends Cubit<VocabularyPracticeSpeakingState> {
  VocabularyPracticeSpeakingCubit() : super(Init());
}
