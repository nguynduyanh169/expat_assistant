import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

class SearchBlogState extends Equatable {
  final List<ListBlog> oldBlogs;
  final List<ListBlog> blogs;
  final int page;
  final SearchBlogStatus status;
  final String message;
  final bool isFirstFetch;

  const SearchBlogState(
      {this.blogs,
      this.oldBlogs,
      this.isFirstFetch,
      this.message,
      this.page,
      this.status});

  @override
  List<Object> get props =>
      [blogs, oldBlogs, isFirstFetch, message, page, status];

  SearchBlogState copyWith(
      {List<ListBlog> oldBlogs,
      List<ListBlog> blogs,
      int page,
      String message,
      bool isFirstFetch,
      SearchBlogStatus status}) {
    return SearchBlogState(
        oldBlogs: oldBlogs ?? this.oldBlogs,
        blogs: blogs ?? this.blogs,
        page: page ?? this.page,
        message: message ?? this.message,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch,
        status: status ?? this.status);
  }
}

enum SearchBlogStatus { init, searching, searchSuccess, searchError }

extension Explaination on SearchBlogStatus {
  bool get isInit => this == SearchBlogStatus.init;

  bool get isSearching => this == SearchBlogStatus.searching;

  bool get isSearchSuccess => this == SearchBlogStatus.searchSuccess;

  bool get isSearchError => this == SearchBlogStatus.searchError;
}
