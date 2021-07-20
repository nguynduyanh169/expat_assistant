import 'package:expat_assistant/src/models/specialist.dart';
import 'package:expat_assistant/src/providers/specialist_provider.dart';
import 'package:flutter/cupertino.dart';

class SpecialistRepository {
  final SpecialistProvider _specialistProvider = SpecialistProvider();

  Future<dynamic> getSpecialistsByRating(
      {@required String token, @required int page, @required int size}) {
    return _specialistProvider.getSpecialistsByRating(
        token: token, page: page, size: size);
  }

  Future<SpecialistDetails> getSpecialistInfo(
      {@required String token, @required int specId}) {
    return _specialistProvider.getSpecialistInfo(token: token, specId: specId);
  }

  Future<dynamic> getSpecialistByName(
      {@required String token, @required int page, @required String keyword}) {
    return _specialistProvider.getSpecialistByName(
        token: token, page: page, keyword: keyword);
  }

  Future<dynamic> getSpecialistByMajorId(
      {@required String token, @required int page, @required int majorId}) {
    return _specialistProvider.getSpecialistByMajorId(
        token: token, page: page, majorId: majorId);
  }

  Future<dynamic> getSpecialistByCreateDate(
      {@required String token, @required int page}) {
    return _specialistProvider.getSpecialistByCreateDate(
        token: token, page: page);
  }
}
