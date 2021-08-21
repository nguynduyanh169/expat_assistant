import 'dart:async';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/majors_filter_cubit.dart';
import 'package:expat_assistant/src/models/major.dart';
import 'package:expat_assistant/src/repositories/major_repository.dart';
import 'package:expat_assistant/src/states/majors_filter_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

Future<Content> showMajors({@required BuildContext context}) async {
  int currentPage = 0;
  List<Content> majors = [];
  Content selected;
  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<MajorFilterCubit>(context).getMajors(currentPage);
      }
    });
  }

  final Content content =
      await showSlidingBottomSheet(context, builder: (context) {
    SizeConfig().init(context);
    return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        headerBuilder: (context, state) {
          return Material(
            child: Container(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
              height: SizeConfig.blockSizeVertical * 8,
              width: double.infinity,
              color: AppColors.MAIN_COLOR,
              alignment: Alignment.centerLeft,
              child: Text('Select a major',
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
          );
        },
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                MajorFilterCubit(MajorRepository())..getMajors(currentPage),
            child: Material(
              child: Container(
                height: SizeConfig.blockSizeVertical * 50,
                child: BlocBuilder<MajorFilterCubit, MajorFilterState>(
                  builder: (context, state) {
                    setupScrollController(context);
                    bool isLoading = false;
                    if (state.status.isLoadingMajors) {
                      majors = state.oldMajors;
                      isLoading = true;
                    } else if (state.status.isLoadedMajors) {
                      majors = state.majors;
                      currentPage = state.page;
                    }
                    return ListView.separated(
                      controller: scrollController,
                      itemCount: majors.length + (isLoading ? 1 : 0),
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                      ),
                      itemBuilder: (context, index) {
                        if (index < majors.length) {
                          return RadioListTile(
                              activeColor: AppColors.MAIN_COLOR,
                              title: Text(
                                majors[index].name,
                                style: GoogleFonts.lato(),
                              ),
                              value: majors[index],
                              groupValue: selected,
                              onChanged: (value) {
                                Navigator.pop(context, majors[index]);
                              });
                        } else {
                          Timer(Duration(milliseconds: 30), () {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          });
                          return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(child: CupertinoActivityIndicator()),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          );
        });
  });
  return content;
}
