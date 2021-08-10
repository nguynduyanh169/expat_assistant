import 'package:expat_assistant/src/models/specialist.dart';
import 'package:random_string/random_string.dart';

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

  static String getChannel() {
    return 'CHANNEL' + randomNumeric(8);
  }

  static String getOrderId() {
    return 'ORDER' + randomNumeric(8);
  }

  static String getRefId() {
    return 'REFID' + randomNumeric(8);
  }

  static String getTransId() {
    return 'TRANSID' + randomNumeric(8);
  }
}
