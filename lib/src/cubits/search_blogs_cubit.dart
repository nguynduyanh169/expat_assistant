import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/search_blogs_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class SearchBlogCubit extends Cubit<SearchBlogState> {
  BlogRepository _blogRepository;
  final HiveUtils _hiveUtils = HiveUtils();

  SearchBlogCubit(this._blogRepository)
      : super(const SearchBlogState(status: SearchBlogStatus.init));

  Future<void> searchBlogs(String keywords, int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isSearching) return null;
      final currentState = state;
      List<ListBlog> oldBlogs = [];
      List<ListBlog> blogs = [];
      if (currentState.status.isSearchSuccess) {
        oldBlogs = state.blogs;
      }
      emit(state.copyWith(
        status: SearchBlogStatus.searching,
        oldBlogs: oldBlogs,
        isFirstFetch: page == 0,
      ));
      var blog = await _blogRepository.getBlogsByTitle(
          token: token, page: page, keywords: keywords);
      if (blog == 204) {
        emit(state.copyWith(
            page: page,
            status: SearchBlogStatus.searchSuccess,
            blogs: oldBlogs));
      } else {
        page++;
        final thisBlogs = state.oldBlogs;
        blogs.addAll(thisBlogs);
        blogs.addAll(blog);
        emit(state.copyWith(
            page: page,
            status: SearchBlogStatus.searchSuccess,
            blogs: blogs));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: SearchBlogStatus.searchError, message: e.toString()));
    }
  }
}
