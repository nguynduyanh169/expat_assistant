import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/home_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class HomeCubit extends Cubit<HomeState> {
  BlogRepository _blogRepository;
  final HiveUtils _hiveUtils = HiveUtils();

  HomeCubit(this._blogRepository)
      : super(const HomeState(status: HomeStatus.init));

  Future<void> getLatestNews(int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoadingBlogs) return null;
      final currentState = state;
      List<ListBlog> oldBlogs = [];
      List<ListBlog> blogs = [];
      if (currentState.status.isLoadBlogsSuccess) {
        oldBlogs = state.blogs;
      }
      emit(state.copyWith(
        status: HomeStatus.loadingBlogs,
        oldBlogs: oldBlogs,
        isFirstFetch: page == 0,
      ));
      var blog = await _blogRepository.getBlogsByPriority(
          token: token, page: page, priority: 2);
      if (blog == 204) {
        emit(state.copyWith(
            pageOfLatestNews: page,
            status: HomeStatus.loadBlogsSuccess,
            blogs: oldBlogs));
      } else {
        page++;
        final thisBlogs = state.oldBlogs;

        blogs.addAll(thisBlogs);
        blogs.addAll(blog.listBlog);
       
        emit(state.copyWith(
            pageOfLatestNews: page,
            status: HomeStatus.loadBlogsSuccess,
            blogs: blogs));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: HomeStatus.loadBlogsFailed, message: e.toString()));
    }
  }
}
