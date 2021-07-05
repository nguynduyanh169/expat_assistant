import 'package:expat_assistant/src/providers/blog_provider.dart';
import 'package:flutter/cupertino.dart';

class BlogRepository {
  final BlogProvider _blogProvider = BlogProvider();

  Future<dynamic> getBlogsByPriority(
      {@required String token, @required int page, @required int priority}) {
    return _blogProvider.getBlogsByPriority(
        token: token, page: page, priority: priority);
  }
}
