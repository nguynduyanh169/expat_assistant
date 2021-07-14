import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/related_news_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class RelatedNewsCubit extends Cubit<RelatedNewsState> {
  BlogRepository _blogRepository;
  HiveUtils _hiveUtils = HiveUtils();

  RelatedNewsCubit(this._blogRepository)
      : super(const RelatedNewsState(status: RelatedNewsStatus.init));

  Future<void> getRelatedNews(
      int page, int categoryId, ListBlog existBlog) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoading) return null;
      final currentState = state;
      List<ListBlog> oldBlogs = [];
      List<ListBlog> blogs = [];
      if (currentState.status.isLoaded) {
        oldBlogs = state.blogs;
      }
      emit(state.copyWith(
        status: RelatedNewsStatus.loading,
        oldBlogs: oldBlogs,
        isFirstFetch: page == 0,
      ));
      var blog = await _blogRepository.getBlogsByCategory(
          token: token, page: page, categoryId: categoryId);
      if (blog == 204) {
        emit(state.copyWith(
            page: page, status: RelatedNewsStatus.loaded, blogs: oldBlogs));
      } else {
        page++;
        final thisBlogs = state.oldBlogs;
        blogs.addAll(thisBlogs);
        blogs.addAll(blog);
        if (blogs.map((item) => item.blogId).contains(existBlog.blogId)) {
          print('contain');
          blogs.removeWhere((item) => item.blogId == existBlog.blogId);
        }
        emit(state.copyWith(
            page: page, status: RelatedNewsStatus.loaded, blogs: blogs));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: RelatedNewsStatus.loadError, message: e.toString()));
    }
  }
}
