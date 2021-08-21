import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/feedback_cubit.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/states/feedback_state.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:expat_assistant/src/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class FeedBackScreen extends StatelessWidget {
  TextEditingController commentController = TextEditingController();
  double rating = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args = ModalRoute.of(context).settings.arguments as FeedbackArgs;
    print(args.sessionId);
    return BlocProvider(
      create: (context) => FeedbackCubit(AppointmentRepository())
        ..initializeFeedback(args.appointmentId),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.popUntil(
                      context, ModalRoute.withName(RouteName.HOME_PAGE)),),
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
            "Feedbacks",
            style: GoogleFonts.lato(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
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
        bottomNavigationBar: BlocBuilder<FeedbackCubit, FeedbackState>(
          builder: (context, state) {
            return BottomAppBar(
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 100,
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 10,
                    right: SizeConfig.blockSizeHorizontal * 10,
                    top: SizeConfig.blockSizeVertical * 1.75,
                    bottom: SizeConfig.blockSizeVertical * 1.75),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(0.2),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10)
                    ]),
                height: SizeConfig.blockSizeVertical * 10,
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.MAIN_COLOR),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            GoogleFonts.lato(fontSize: 17))),
                    child: Text("Send Feedback"),
                    onPressed: () => BlocProvider.of<FeedbackCubit>(context)
                        .feedBack(commentController.text.trim(),
                            args.appointmentId, rating),
                  ),
                ),
              ),
            );
          },
        ),
        body: BlocConsumer<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            if (state.status.isFeedbacking) {
              CustomLoadingDialog.loadingDialog(
                  context: context, message: 'Sending...');
            } else if (state.status.isFeedbackCompleted) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'Feedback done!',
                  color: Colors.green);
            } else if (state.status.isFeedbackError) {
              Navigator.pop(context);
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: 'Feedback failed!',
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state.status.isLoading) {
              return LoadingView(message: 'Loading...');
            } else {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        ClipRRect(
                          child: Image(
                            height: SizeConfig.blockSizeVertical * 25,
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/feedback.png'),
                          ),
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 30,
                        )
                      ],
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 100,
                      padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 20,
                          ),
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            height: SizeConfig.blockSizeVertical * 52,
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 3),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.1),
                                      offset: Offset(0.0, 6.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.10)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 87,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Rate Your Experience',
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                          'Are you satified with the service of Dr. ${args.sepcialistName}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    CupertinoIcons.star_fill,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    rating = rating;
                                  },
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2,
                                ),
                                Text(
                                  'Tell us what can be improved!',
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 2,
                                ),
                                TextFormField(
                                    style: GoogleFonts.lato(),
                                    controller: commentController,
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.black12,
                                      hintText: 'Enter your comment ...',
                                      hintStyle: GoogleFonts.lato(),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
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

class FeedbackArgs {
  final int appointmentId;
  final String sepcialistName;
  final int sessionId;

  const FeedbackArgs(this.appointmentId, this.sepcialistName, this.sessionId);
}
