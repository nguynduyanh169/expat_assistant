// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  Blog({
    this.totalItems,
    this.totalPages,
    this.listBlog,
    this.currentPage,
  });

  int totalItems;
  int totalPages;
  List<ListBlog> listBlog;
  int currentPage;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        listBlog: List<ListBlog>.from(
            json["listBlog"].map((x) => ListBlog.fromJson(x))),
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalPages": totalPages,
        "listBlog": List<dynamic>.from(listBlog.map((x) => x.toJson())),
        "currentPage": currentPage,
      };
}

class ListBlog {
  ListBlog({
    this.blogId,
    this.channel,
    this.category,
    this.createBy,
    this.blogTitle,
    this.blogContent,
    this.coverLink,
    this.createDate,
    this.priority,
  });

  int blogId;
  Channel channel;
  Category category;
  String createBy;
  String blogTitle;
  String blogContent;
  String coverLink;
  List<int> createDate;
  int priority;

  factory ListBlog.fromJson(Map<String, dynamic> json) => ListBlog(
        blogId: json["blogId"],
        channel: Channel.fromJson(json["channel"]),
        category: Category.fromJson(json["category"]),
        createBy: json["createBy"],
        blogTitle: json["blogTitle"],
        blogContent: json["blogContent"],
        coverLink: json["cover_link"],
        createDate: List<int>.from(json["createDate"].map((x) => x)),
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "blogId": blogId,
        "channel": channel.toJson(),
        "category": category.toJson(),
        "createBy": createBy,
        "blogTitle": blogTitle,
        "blogContent": blogContent,
        "cover_link": coverLink,
        "createDate": List<dynamic>.from(createDate.map((x) => x)),
        "priority": priority,
      };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
  });

  int categoryId;
  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
      };
}

class Channel {
  Channel({
    this.channelId,
    this.createBy,
    this.description,
    this.channelName,
    this.image,
    this.status,
  });

  int channelId;
  String createBy;
  String description;
  String channelName;
  String image;
  int status;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        channelId: json["channelId"],
        createBy: json["createBy"],
        description: json["description"],
        channelName: json["channelName"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "createBy": createBy,
        "description": description,
        "channelName": channelName,
        "image": image,
        "status": status,
      };
}
