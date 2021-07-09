import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/blog_details_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';
import 'package:flutter/material.dart';

class BlogDetailsCubit extends Cubit<BlogDetailsState> {
  BlogRepository _blogRepository;
  final HiveUtils _hiveUtils = HiveUtils();
  BlogDetailsCubit(this._blogRepository)
      : super(const BlogDetailsState(status: BlogDetailsStatus.init));

  Future<void> getBlogDetails(int blogId) async {
    emit(state.copyWith(
        status: BlogDetailsStatus.loadingBlog, message: 'Cannot load blog'));
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      ListBlog blog =
          await _blogRepository.getBlogInfoById(token: token, blogId: blogId);
      if (blog == null) {
        emit(state.copyWith(
            status: BlogDetailsStatus.loadBlogFailed,
            message: 'Cannot load blog'));
      } else {
        emit(state.copyWith(
            blog: blog, status: BlogDetailsStatus.loadBlogSuccess));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: BlogDetailsStatus.loadBlogFailed, message: e.toString()));
    }
  }
}
