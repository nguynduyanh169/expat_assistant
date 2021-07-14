import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

enum RelatedNewsStatus { init, loading, loaded, loadError }

extension Explanation on RelatedNewsStatus {
  bool get isInit => this == RelatedNewsStatus.init;

  bool get isLoading => this == RelatedNewsStatus.loading;

  bool get isLoaded => this == RelatedNewsStatus.loaded;

  bool get isLoadError => this == RelatedNewsStatus.loadError;
}

class RelatedNewsState extends Equatable {
  final List<ListBlog> oldBlogs;
  final List<ListBlog> blogs;
  final int page;
  final RelatedNewsStatus status;
  final String message;
  final bool isFirstFetch;

  const RelatedNewsState(
      {this.blogs,
      this.oldBlogs,
      this.isFirstFetch,
      this.status,
      this.message,
      this.page});

  RelatedNewsState copyWith(
      {List<ListBlog> oldBlogs,
      List<ListBlog> blogs,
      int page,
      RelatedNewsStatus status,
      String message,
      bool isFirstFetch}) {
    return RelatedNewsState(
        oldBlogs: oldBlogs ?? this.oldBlogs,
        blogs: blogs ?? this.blogs,
        page: page ?? this.page,
        status: status ?? this.status,
        message: message ?? this.message,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch);
  }

  @override
  // TODO: implement props
  List<Object> get props => [oldBlogs, blogs, page, status, message, isFirstFetch];
}
