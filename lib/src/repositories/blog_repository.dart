import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/providers/blog_provider.dart';
import 'package:flutter/cupertino.dart';

class BlogRepository {
  final BlogProvider _blogProvider = BlogProvider();

  Future<dynamic> getBlogsByPriority(
      {@required String token, @required int page, @required int priority}) {
    return _blogProvider.getBlogsByPriority(
        token: token, page: page, priority: priority);
  }

  Future<dynamic> getBlogsPaging({@required String token, @required int page}) {
    return _blogProvider.getBlogs(token: token, page: page);
  }

  Future<dynamic> getBlogsByChannel(
      {@required String token, @required int page, @required int channelId}) {
    return _blogProvider.getBlogsByChannel(
        token: token, page: page, channelId: channelId);
  }

  Future<dynamic> getBlogsByTitle(
      {@required String token, @required int page, @required String keywords}) {
    return _blogProvider.getBlogsByTitle(
        token: token, page: page, keywords: keywords);
  }

  Future<ListBlog> getBlogInfoById(
      {@required String token, @required int blogId}) {
    return _blogProvider.getBlogInfoById(token: token, blogId: blogId);
  }

  Future<dynamic> getBlogsByCategory(
      {@required String token, @required int page, @required int categoryId}) {
    return _blogProvider.getBlogsByCategory(
        token: token, page: page, categoryId: categoryId);
  }

  Future<dynamic> getBlogsByDate(
      {@required String token, @required String date, @required int page}) {
    return _blogProvider.getBlogsByDate(token: token, date: date, page: page);
  }
}
