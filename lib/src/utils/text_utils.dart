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

  static String getUid() {
    return randomNumeric(4);
  }

  static String getFoodName(String key) {
    Map<String, String> foodMap = {
      'pho': 'Phở',
      'nem chua': "Nem chua",
      'goi cuon': "Gỏi cuốn",
      'com tam': "Cơm tấm",
      'ca kho to': "Cá kho tộ",
      'bun dau mam tom': "Bún đậu mắm tôm",
      'bun bo hue': "Bún bò huế",
      'banh xeo': "Bánh xèo",
      'banh trang nuong': "Bánh tráng nướng",
      'banh pia': "Bánh pía",
      'banh mi': "Bánh mì",
      'banh gio': "Bánh giò",
      'banh cuon': "Bánh cuốn",
      'banh chung': "Bánh chưng",
      'banh canh': "Bánh canh ",
      'banh can': "Bánh căn",
      'banh beo': "Bánh bèo",
    };

    return foodMap[key];
  }
}
