import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

enum ThumbnailsStatus {
  init,
  loadingPrioritizedBlogs,
  loadPrioritizedBlogsSuccess,
  loadPrioritizedBlogsFailed,
}

extension Explanation on ThumbnailsStatus {
  bool get isInit => this == ThumbnailsStatus.init;
  bool get isLoadingPrioritized =>
      this == ThumbnailsStatus.loadingPrioritizedBlogs;

  bool get isLoadPrioritizedSuccess =>
      this == ThumbnailsStatus.loadPrioritizedBlogsSuccess;

  bool get isLoadPrioritizedFailed =>
      this == ThumbnailsStatus.loadPrioritizedBlogsFailed;
}

class ThumbnailsState extends Equatable {
  final List<ListBlog> prioritizedBlogs;
  final List<ListBlog> oldPrioritizedBlogs;
  final String message;
  final ThumbnailsStatus status;
  final int page;
  final bool isPriorityFirstFetch;

  const ThumbnailsState(
      {this.prioritizedBlogs,
      this.message,
      this.status,
      this.oldPrioritizedBlogs,
      this.isPriorityFirstFetch,
      this.page});

  @override
  List<Object> get props => [
        prioritizedBlogs,
        message,
        status,
        oldPrioritizedBlogs,
        isPriorityFirstFetch,
        page,
      ];

  ThumbnailsState copyWith(
      {List<ListBlog> prioritizedBlogs,
      String message,
      ThumbnailsStatus status,
      List<ListBlog> oldPrioritizedBlogs,
      int page,
      bool isPriorityFirstFetch}) {
    return ThumbnailsState(
        prioritizedBlogs: prioritizedBlogs ?? this.prioritizedBlogs,
        message: message ?? this.message,
        status: status ?? this.status,
        oldPrioritizedBlogs: oldPrioritizedBlogs ?? this.oldPrioritizedBlogs,
        isPriorityFirstFetch: isPriorityFirstFetch ?? this.isPriorityFirstFetch,
        page: page ?? this.page);
  }
}
