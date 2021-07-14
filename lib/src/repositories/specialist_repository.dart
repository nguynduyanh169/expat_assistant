import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/providers/specialist_provider.dart';
import 'package:flutter/cupertino.dart';

class SpecialistRepository {
  final SpecialistProvider _specialistProvider = SpecialistProvider();

  Future<dynamic> getSpecialistsByRating(
      {@required String token, @required int page}) {
    return _specialistProvider.getSpecialistsByRating(token: token, page: page);
  }

  Future<SpecialistDetails> getSpecialistInfo(
      {@required String token, @required int specId}) {
    return _specialistProvider.getSpecialistInfo(token: token, specId: specId);
  }
}
