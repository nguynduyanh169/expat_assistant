import 'package:expat_assistant/src/models/specialist.dart';

class TextUtils {
  String getLanguages({List<Language> languages}) {
    var concatenate = StringBuffer();
    for (int i = 0; i < languages.length; i++) {
      if (i == 0) {
        concatenate.write(languages[i].languageName);
      } else {
        concatenate.write(", " + languages[i].languageName);
      }
    }
    return concatenate.toString();
  }
}
