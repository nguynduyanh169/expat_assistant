import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/blogs_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class BlogsCubit extends Cubit<BlogsState> {
  BlogRepository _blogRepository;
  final HiveUtils _hiveUtils = HiveUtils();

  BlogsCubit(this._blogRepository)
      : super(const BlogsState(status: BlogsStatus.init));

  Future<void> getBlogsPaging(int page) async {
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
        status: BlogsStatus.loadingBlogs,
        oldBlogs: oldBlogs,
        isFirstFetch: page == 0,
      ));
      var blog = await _blogRepository.getBlogsPaging(token: token, page: page);
      if (blog == 204) {
        emit(state.copyWith(
            page: page, status: BlogsStatus.loadBlogsSuccess, blogs: oldBlogs));
      } else {
        page++;
        final thisBlogs = state.oldBlogs;
        blogs.addAll(thisBlogs);
        blogs.addAll(blog);
        emit(state.copyWith(
            page: page, status: BlogsStatus.loadBlogsSuccess, blogs: blogs));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: BlogsStatus.loadBlogsFailed, message: e.toString()));
    }
  }

  Future<void> getBlogByCategory(int page, int categoryId) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoadingBlogCategory) return null;
      final currentState = state;
      List<ListBlog> oldBlogs = [];
      List<ListBlog> blogs = [];
      if (currentState.status.isLoadBlogCategorySuccess) {
        oldBlogs = state.blogsCategory;
      }
      emit(state.copyWith(
        status: BlogsStatus.loadingBlogCategory,
        oldBlogsCategory: oldBlogs,
        isFirstFetch: page == 0,
      ));
      var blog = await _blogRepository.getBlogsByCategory(
          token: token, page: page, categoryId: categoryId);
      if (blog == 204) {
        emit(state.copyWith(
            page: page,
            status: BlogsStatus.loadBlogCategorySuccess,
            blogsCategory: oldBlogs));
      } else {
        page++;
        final thisBlogs = state.oldBlogsCategory;
        blogs.addAll(thisBlogs);
        blogs.addAll(blog);
        emit(state.copyWith(
            page: page,
            status: BlogsStatus.loadBlogCategorySuccess,
            blogsCategory: blogs));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: BlogsStatus.loadBlogCategoryFailed, message: e.toString()));
    }
  }

  Future<void> getBlogByDate(int page, String date) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoadingBlogDate) return null;
      final currentState = state;
      List<ListBlog> oldBlogs = [];
      List<ListBlog> blogs = [];
      if (currentState.status.isLoadBlogDateSuccess) {
        oldBlogs = state.blogsDate;
      }
      emit(state.copyWith(
        status: BlogsStatus.loadingBlogDate,
        oldBlogsDate: oldBlogs,
        isFirstFetch: page == 0,
      ));
      var blog = await _blogRepository.getBlogsByDate(
          token: token, date: date, page: page);
      if (blog == 204) {
        emit(state.copyWith(
            page: page,
            status: BlogsStatus.loadBlogDateSuccess,
            blogsDate: oldBlogs));
      } else {
        page++;
        final thisBlogs = state.oldBlogsDate;
        blogs.addAll(thisBlogs);
        blogs.addAll(blog);
        emit(state.copyWith(
            page: page,
            status: BlogsStatus.loadBlogDateSuccess,
            blogsDate: blogs));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: BlogsStatus.loadBlogDateFailed, message: e.toString()));
    }
  }
}
