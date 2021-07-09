import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

enum BlogsStatus {
  init,
  loadingBlogs,
  loadBlogsSuccess,
  loadBlogsFailed,
  loadingBlogCategory,
  loadBlogCategorySuccess,
  loadBlogCategoryFailed,
  loadingBlogDate,
  loadBlogDateSuccess,
  loadBlogDateFailed
}

extension Explanation on BlogsStatus {
  bool get isInit => this == BlogsStatus.init;

  bool get isLoadingBlogs => this == BlogsStatus.loadingBlogs;

  bool get isLoadBlogsSuccess => this == BlogsStatus.loadBlogsSuccess;

  bool get isLoadBlogsFailed => this == BlogsStatus.loadBlogsFailed;

  bool get isLoadingBlogCategory => this == BlogsStatus.loadingBlogCategory;

  bool get isLoadBlogCategorySuccess =>
      this == BlogsStatus.loadBlogCategorySuccess;

  bool get isLoadBlogCategoryFailed =>
      this == BlogsStatus.loadBlogCategoryFailed;

  bool get isLoadingBlogDate => this == BlogsStatus.loadingBlogDate;

  bool get isLoadBlogDateSuccess => this == BlogsStatus.loadBlogDateSuccess;

  bool get isLoadBlogDateFailed => this == BlogsStatus.loadBlogCategoryFailed;
}

class BlogsState extends Equatable {
  final List<ListBlog> blogs;
  final List<ListBlog> oldBlogs;
  final List<ListBlog> blogsCategory;
  final List<ListBlog> oldBlogsCategory;
  final List<ListBlog> blogsDate;
  final List<ListBlog> oldBlogsDate;
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
      this.isFirstFetch,
      this.blogsCategory,
      this.oldBlogsCategory,
      this.blogsDate,
      this.oldBlogsDate});

  @override
  // TODO: implement props
  List<Object> get props => [
        blogs,
        oldBlogs,
        message,
        status,
        page,
        isFirstFetch,
        oldBlogsCategory,
        blogsCategory,
        blogsDate,
        oldBlogsDate
      ];

  BlogsState copyWith(
      {List<ListBlog> blogs,
      List<ListBlog> oldBlogs,
      List<ListBlog> blogsCategory,
      List<ListBlog> oldBlogsCategory,
      String message,
      BlogsStatus status,
      int page,
      bool isFirstFetch,
      List<ListBlog> blogsDate,
      List<ListBlog> oldBlogsDate}) {
    return BlogsState(
        blogs: blogs ?? this.blogs,
        oldBlogs: oldBlogs ?? this.oldBlogs,
        message: message ?? this.message,
        status: status ?? this.status,
        page: page ?? this.page,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch,
        oldBlogsCategory: oldBlogsCategory ?? this.oldBlogsCategory,
        blogsCategory: blogsCategory ?? this.blogsCategory,
        blogsDate: blogsDate ?? this.blogsDate,
        oldBlogsDate: oldBlogsDate ?? this.oldBlogsDate);
  }
}
