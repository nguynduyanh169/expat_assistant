import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/character_description.dart';
import 'package:expat_assistant/src/states/vocabulary_practice_listening_state.dart';

class VocabularyPracticeListeningCubit extends Cubit<VocabularyPracticeListeningState>{
  VocabularyPracticeListeningCubit(): super(Init());

  Future<void> loadCharacters(String vietnamese) async{
    try{
      var chars = vietnamese.toUpperCase().split('');
      chars.shuffle();
      emit(Loaded(chars));
    }on Exception{
      emit(LoadError());
    }
  }

  Future<void> checkAnswer(String learnerAns, String vietnamese) async{
    print(vietnamese);
    if(learnerAns.trim().toUpperCase() == vietnamese.trim().toUpperCase()){
      emit(CorrectAnswer());
    }else{
      emit(IncorrectAnswer());
    }
  }

  Future<void> addCharacters(CharacterDescription character) async{
    emit(AddCharacter(character));
  }

  Future<void> playAudio() async{
    emit(PlayAudio());
  }

  Future<void> stopAudio() async{
    emit(StoppedAudio());
  }

}