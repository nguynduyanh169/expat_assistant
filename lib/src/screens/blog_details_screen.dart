import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/blog_details_cubit.dart';
import 'package:expat_assistant/src/models/blog.dart';
import 'package:expat_assistant/src/repositories/blog_repository.dart';
import 'package:expat_assistant/src/states/blog_details_state.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BlogDetailsScreen extends StatelessWidget {
  ListBlog blog;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    DateTimeUtils _dateUtils = DateTimeUtils();
    final args =
        ModalRoute.of(context).settings.arguments as BlogDetailsArguments;
    return BlocProvider(
      create: (context) =>
          BlogDetailsCubit(BlogRepository())..getBlogDetails(args.blogId),
      child: Scaffold(
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
            "Read News",
            style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(RouteName.HOME_PAGE));
                },
                icon: Icon(CupertinoIcons.home)),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            )
          ],
        ),
        body: BlocBuilder<BlogDetailsCubit, BlogDetailsState>(
          builder: (context, state) {
            if (state.status.isLoadingBlog) {
              return LoadingView(message: 'Loading...');
            } else {
              if (state.status.isLoadBlogSuccess) {
                blog = state.blog;
              }
              return Container(
                child: ListView(
                  children: <Widget>[
                    ClipRRect(
                      child: Image(
                        width: SizeConfig.blockSizeHorizontal * 100,
                        height: SizeConfig.blockSizeVertical * 24,
                        fit: BoxFit.cover,
                        image: NetworkImage(blog.coverLink),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2),
                      child: Row(
                        children: <Widget>[
                          Text(
                            blog.category.categoryName.toUpperCase(),
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.bold),
                          ),
                          Text(' | '),
                          Text(
                            _dateUtils.getDateTimeForNews(startDateTime: blog.createDate),
                            style: GoogleFonts.lato(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2),
                      child: Text(
                        blog.blogTitle,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 1,
                          right: SizeConfig.blockSizeHorizontal * 1),
                      child: Html(
                        data: blog.blogContent,
                        style: {
                          "p": Style(fontSize: FontSize(17)),
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class BlogDetailsArguments {
  final int blogId;

  const BlogDetailsArguments(this.blogId);
}
