import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/blog.dart';

enum BlogDetailsStatus {
  init,
  loadingBlog,
  loadBlogSuccess,
  loadBlogFailed,
}

extension Explanation on BlogDetailsStatus {
  bool get isInit => this == BlogDetailsStatus.init;

  bool get isLoadingBlog => this == BlogDetailsStatus.loadingBlog;

  bool get isLoadBlogSuccess => this == BlogDetailsStatus.loadBlogSuccess;

  bool get isLoadBlogFailed => this == BlogDetailsStatus.loadBlogFailed;

}

class BlogDetailsState extends Equatable {
  final ListBlog blog;
  final BlogDetailsStatus status;
  final String message;
  final int categoryId;

  const BlogDetailsState(
      {this.blog, this.message, this.status, this.categoryId});

  @override
  // TODO: implement props
  List<Object> get props => [status, blog, message];

  BlogDetailsState copyWith(
      {ListBlog blog,
      BlogDetailsStatus status,
      String message,
      int categoryId}) {
    return BlogDetailsState(
        blog: blog ?? this.blog,
        status: status ?? this.status,
        message: message ?? this.message,
        categoryId: categoryId ?? this.categoryId);
  }
}
