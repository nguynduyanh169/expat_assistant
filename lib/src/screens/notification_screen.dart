import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/notifications_cubit.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/states/notifications_state.dart';
import 'package:expat_assistant/src/utils/date_utils.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Notifications> notifications = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => NotificationsCubit()..getNotifications(),
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
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Notifications',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return LoadingView(message: 'Loading...');
            } else {
              if (state.status.isLoaded) {
                notifications = state.notiList;
              }
              return Container(
                child: RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<NotificationsCubit>(context)
                        .getNotifications();
                  },
                  child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                            leading: Icon(
                              LineIcons.phoneVolume,
                              color: AppColors.MAIN_COLOR,
                            ),
                            title: Text(
                              notifications[index].title,
                              style: GoogleFonts.lato(),
                            ),
                            subtitle: Text(
                              notifications[index].content,
                              style: GoogleFonts.lato(),
                            ),
                            trailing: Text(
                              DateTimeUtils.caculateDaysNoti(
                                          date: notifications[index].sentDate)
                                      .toString() +
                                  " minutes ago",
                              style: GoogleFonts.lato(),
                            ),
                          ),
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.black54,
                            height: 2,
                          ),
                      itemCount: notifications.length),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
