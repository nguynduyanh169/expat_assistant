import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/thumbnails_home_state.dart';
import 'package:expat_assistant/src/utils/hive_utils.dart';

class ThumbnailsHomeCubit extends Cubit<ThumbnailsState> {
  BlogRepository _blogRepository;
  HiveUtils _hiveUtils = HiveUtils();
  ThumbnailsHomeCubit(this._blogRepository)
      : super(const ThumbnailsState(status: ThumbnailsStatus.init));

  
  Future<void> getPrioritizedBlogs(int page) async {
    try {
      Map<dynamic, dynamic> loginResponse =
          _hiveUtils.getUserAuth(boxName: HiveBoxName.USER_AUTH);
      String token = loginResponse['token'].toString();
      if (state.status.isLoadingPrioritized) return null;
      final currentState = state;
      List<ListBlog> oldPrioritizedBlogs = [];
      List<ListBlog> prioritizedBlogs = [];
      if (currentState.status.isLoadPrioritizedSuccess) {
        oldPrioritizedBlogs = state.prioritizedBlogs;
      }
      emit(state.copyWith(
        status: ThumbnailsStatus.loadingPrioritizedBlogs,
        oldPrioritizedBlogs: oldPrioritizedBlogs,
        isPriorityFirstFetch: page == 0,
      ));
      var blog = await _blogRepository.getBlogsByPriority(
          token: token, page: page, priority: 1);
      if (blog == 204) {
        emit(state.copyWith(
            page: page,
            status: ThumbnailsStatus.loadPrioritizedBlogsSuccess,
            prioritizedBlogs: oldPrioritizedBlogs));
      } else {
        page++;
        final blogs = state.oldPrioritizedBlogs;
        prioritizedBlogs.addAll(blogs);
        prioritizedBlogs.addAll(blog.listBlog);
        emit(state.copyWith(
            page: page,
            status: ThumbnailsStatus.loadPrioritizedBlogsSuccess,
            prioritizedBlogs: prioritizedBlogs));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: ThumbnailsStatus.loadPrioritizedBlogsFailed,
          message: e.toString()));
    }
  }
}
