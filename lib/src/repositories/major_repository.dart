import 'package:expat_assistant/src/providers/major_provider.dart';
import 'package:flutter/cupertino.dart';

class MajorRepository {
  final MajorProvider _majorProvider = MajorProvider();

  Future<dynamic> getMajors({@required String token, @required int page}) {
    return _majorProvider.getMajors(token: token, page: page);
  }
}
