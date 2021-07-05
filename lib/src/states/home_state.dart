import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

enum HomeStatus {
  init,
  loadingBlogs,
  loadBlogsSuccess,
  loadBlogsFailed
}

extension Explanation on HomeStatus {
  bool get isInit => this == HomeStatus.init;
  
  bool get isLoadingBlogs => this == HomeStatus.loadingBlogs;

  bool get isLoadBlogsSuccess => this == HomeStatus.loadBlogsSuccess;

  bool get isLoadBlogsFailed => this == HomeStatus.loadBlogsFailed;
}

class HomeState extends Equatable {
  final List<ListBlog> blogs;
  final List<ListBlog> oldBlogs;
  final String message;
  final HomeStatus status;
  final int pageOfLatestNews;
  final bool isFirstFetch;

  const HomeState(
      {this.message,
      this.status,
      this.blogs,
      this.oldBlogs,
      this.isFirstFetch,
      this.pageOfLatestNews});

  @override
  List<Object> get props =>
      [message, status, blogs, oldBlogs, isFirstFetch, pageOfLatestNews];

  HomeState copyWith(
      {String message,
      HomeStatus status,
      bool isPriorityFirstFetch,
      List<ListBlog> blogs,
      List<ListBlog> oldBlogs,
      int pageOfLatestNews,
      bool isFirstFetch}) {
    return HomeState(
        message: message ?? this.message,
        status: status ?? this.status,
        blogs: blogs ?? this.blogs,
        oldBlogs: oldBlogs ?? this.oldBlogs,
        pageOfLatestNews: pageOfLatestNews ?? this.pageOfLatestNews,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch);
  }
}
