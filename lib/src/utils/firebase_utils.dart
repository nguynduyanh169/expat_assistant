import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseUtils {
  static Future<String> uploadImage({File image, String folderName}) async {
    String imageUrl;
    String fileName = basename(image.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child('$folderName/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    imageUrl = downloadUrl.toString();
    print(imageUrl);
    return imageUrl;
  }
}
