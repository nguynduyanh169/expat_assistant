import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/blogs_cubit.dart';
import 'package:expat_assistant/src/cubits/search_blogs_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/screens/blog_details_screen.dart';
import 'package:expat_assistant/src/screens/channel_screen.dart';
import 'package:expat_assistant/src/states/blogs_state.dart';
import 'package:expat_assistant/src/widgets/alert_dialog_vocabulary.dart';
import 'package:expat_assistant/src/widgets/channel_list.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/news_card.dart';
import 'package:expat_assistant/src/widgets/search_blogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BlogsScreen extends StatefulWidget {
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  int currentPage = 0;
  final ScrollController newsScrollController = ScrollController();
  List<ListBlog> news = [];
  List<Category> categoryList = [
    Category(categoryId: 1, categoryName: 'Health'),
    Category(categoryId: 2, categoryName: 'Travel'),
    Category(categoryId: 3, categoryName: 'Greetings')
  ];
  Category category = Category(categoryId: 0, categoryName: 'Category');
  DateTime selectedDate = DateTime.now();
  bool isFilterByDate = false;
  bool isFilterByCategory = false;

  void setupScrollController(BuildContext context) {
    newsScrollController.addListener(() {
      if (newsScrollController.position.pixels ==
          newsScrollController.position.maxScrollExtent) {
        if (isFilterByCategory == true) {
          BlocProvider.of<BlogsCubit>(context)
              .getBlogByCategory(currentPage, category.categoryId);
        } else if (isFilterByDate == true) {
          BlocProvider.of<BlogsCubit>(context).getBlogByDate(
              currentPage, DateFormat('yyyy-MM-dd').format(selectedDate));
        } else {
          BlocProvider.of<BlogsCubit>(context).getBlogsPaging(currentPage);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          BlogsCubit(BlogRepository())..getBlogsPaging(currentPage),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(245, 244, 244, 2),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black38,
                height: 0.25,
              ),
              preferredSize: Size.fromHeight(0.25)),
          elevation: 0.5,
          backgroundColor: AppColors.MAIN_COLOR,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            'News',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          actions: [
            BlocProvider(
                create: (context) => SearchBlogCubit(BlogRepository()),
                child: Builder(
                  builder: (context) => IconButton(
                      onPressed: () {
                        showSearch<ListBlog>(
                            context: context,
                            delegate: SearchBlogs(
                                searchBlogCubit:
                                    BlocProvider.of<SearchBlogCubit>(context)));
                      },
                      icon: Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      )),
                )),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 5,
            ),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              BlocBuilder<BlogsCubit, BlogsState>(builder: (context, state) {
                return ChannelList();
              }),
              BlocBuilder<BlogsCubit, BlogsState>(builder: (context, state) {
                setupScrollController(context);
                if ((state.isFirstFetch && state.status.isLoadingBlogs) ||
                    (state.status.isLoadingBlogCategory &&
                        state.isFirstFetch) ||
                    (state.status.isLoadingBlogDate && state.isFirstFetch)) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 30,
                      ),
                      LoadingView(message: 'Loading...')
                    ],
                  );
                }
                bool isLoadingNews = false;
                if (state.status.isLoadingBlogs) {
                  news = state.oldBlogs;
                  isLoadingNews = true;
                } else if (state.status.isLoadBlogsSuccess) {
                  news = state.blogs;
                  currentPage = state.page;
                } else if (state.status.isLoadingBlogCategory) {
                  news = state.oldBlogsCategory;
                  isLoadingNews = true;
                } else if (state.status.isLoadBlogCategorySuccess) {
                  news = state.blogsCategory;
                  currentPage = state.page;
                } else if (state.status.isLoadingBlogDate) {
                  news = state.oldBlogsDate;
                  isLoadingNews = true;
                } else if (state.status.isLoadBlogDateSuccess) {
                  news = state.blogsDate;
                  currentPage = state.page;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 100,
                      height: SizeConfig.blockSizeVertical * 7.5,
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          top: SizeConfig.blockSizeHorizontal * 3,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showCategory(context: context, list: categoryList)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    category = value;
                                    currentPage = 0;
                                    isFilterByCategory = true;
                                    isFilterByDate = false;
                                    news.clear();
                                  });
                                  BlocProvider.of<BlogsCubit>(context)
                                      .getBlogByCategory(
                                          currentPage, category.categoryId);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal * 3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                color: isFilterByCategory == true
                                    ? AppColors.MAIN_COLOR
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    CupertinoIcons.square_list,
                                    size: 16,
                                    color: isFilterByCategory == true
                                        ? Colors.white
                                        : AppColors.MAIN_COLOR,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Text(category.categoryName,
                                      style: GoogleFonts.lato(
                                          color: isFilterByCategory == true
                                              ? Colors.white
                                              : Colors.black))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          InkWell(
                            onTap: () async {
                              final DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101));
                              if (picked != null && picked != selectedDate)
                                setState(() {
                                  selectedDate = picked;
                                  currentPage = 0;
                                  isFilterByCategory = false;
                                  isFilterByDate = true;
                                  news.clear();
                                });
                              BlocProvider.of<BlogsCubit>(context)
                                  .getBlogByDate(
                                      currentPage,
                                      DateFormat('yyyy-MM-dd')
                                          .format(selectedDate));
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal * 3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                color: isFilterByDate == true
                                    ? AppColors.MAIN_COLOR
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    CupertinoIcons.calendar,
                                    size: 16,
                                    color: isFilterByDate == true
                                        ? Colors.white
                                        : AppColors.MAIN_COLOR,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Text(
                                      isFilterByDate == true
                                          ? DateFormat('yyyy-MM-dd')
                                              .format(selectedDate)
                                          : 'Date',
                                      style: GoogleFonts.lato(
                                          color: isFilterByDate == true
                                              ? Colors.white
                                              : Colors.black))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                category = Category(
                                    categoryId: 0, categoryName: 'Category');
                                selectedDate = DateTime.now();
                                currentPage = 0;
                                isFilterByCategory = false;
                                isFilterByDate = false;
                                news.clear();
                              });
                              BlocProvider.of<BlogsCubit>(context)
                                  .getBlogsPaging(currentPage);
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal * 3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    CupertinoIcons.refresh_bold,
                                    size: 16,
                                    color: AppColors.MAIN_COLOR,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Text('Refresh', style: GoogleFonts.lato())
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2),
                      child: Text(
                        'Latest News',
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 99, 99, 30)),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      height: SizeConfig.blockSizeVertical * 53.3,
                      child: ListView.separated(
                        controller: newsScrollController,
                        separatorBuilder: (context, index) => SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        itemCount: news.length + (isLoadingNews ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < news.length) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 1,
                                  right: SizeConfig.blockSizeHorizontal * 1),
                              child: ChannelCard(
                                blog: news[index],
                                openChannel: () => Navigator.pushNamed(
                                    context, RouteName.CHANNEL,
                                    arguments: ChannelDetailsArguments(
                                        news[index].channel)),
                                openNews: () => Navigator.pushNamed(
                                    context, RouteName.BLOG_DETAILS,
                                    arguments: BlogDetailsArguments(
                                        news[index].blogId)),
                              ),
                            );
                          } else {
                            Timer(Duration(milliseconds: 30), () {
                              newsScrollController.jumpTo(newsScrollController
                                  .position.maxScrollExtent);
                            });
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  Center(child: CupertinoActivityIndicator()),
                            );
                          }
                        },
                      ),
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
