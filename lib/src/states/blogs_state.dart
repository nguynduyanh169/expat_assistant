import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

enum BlogsStatus { init, loadingBlogs, loadBlogsSuccess, loadBlogsFailed }

extension Explanation on BlogsStatus {
  bool get isInit => this == BlogsStatus.init;

  bool get isLoadingBlogs => this == BlogsStatus.loadingBlogs;

  bool get isLoadBlogsSuccess => this == BlogsStatus.loadBlogsSuccess;

  bool get isLoadBlogsFailed => this == BlogsStatus.loadBlogsFailed;
}

class BlogsState extends Equatable {
  final List<ListBlog> blogs;
  final List<ListBlog> oldBlogs;
  final String message;
  final BlogsStatus status;
  final int page;
  final bool isFirstFetch;

  const BlogsState(
      {this.blogs,
      this.oldBlogs,
      this.message,
      this.status,
      this.page,
      this.isFirstFetch});

  @override
  // TODO: implement props
  List<Object> get props =>
      [blogs, oldBlogs, message, status, page, isFirstFetch];

  BlogsState copyWith(
      {List<ListBlog> blogs,
      List<ListBlog> oldBlogs,
      String message,
      BlogsStatus status,
      int page,
      bool isFirstFetch}) {
    return BlogsState(
        blogs: blogs ?? this.blogs,
        oldBlogs: oldBlogs ?? this.oldBlogs,
        message: message ?? this.message,
        status: status ?? this.status,
        page: page ?? this.page,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch);
  }
}
