import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/today_appointment_cubit.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/screens/call_room_screen.dart';
import 'package:expat_assistant/src/states/today_appointment_state.dart';
import 'package:expat_assistant/src/utils/value_notifier_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appointment_card.dart';

// ignore: must_be_immutable
class TodayAppointment extends StatefulWidget {
  TodayAppointment();
  @override
  _TodayAppointmentState createState() => _TodayAppointmentState();
}

class _TodayAppointmentState extends State<TodayAppointment> {
  ExpatAppointment appointment;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          TodayAppointmentCubit(AppointmentRepository())..getTodayAppointment(),
      child: BlocBuilder<TodayAppointmentCubit, TodayAppointmentState>(
        builder: (context, state) {
          if (state.status.isLoadingAppointment) {
            return Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              height: SizeConfig.blockSizeVertical * 22,
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 0.5,
                ),
              ),
            );
          } else if (state.status.isLoadedNoAppointment ||
              state.status.isLoadAppointmentError ||
              state.appointment == null) {
            return Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              height: SizeConfig.blockSizeVertical * 22,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.05),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: Center(
                child: Text(
                  'There is no upcomming appointment',
                  style: GoogleFonts.lato(fontSize: 20),
                ),
              ),
            );
          } else {
            if (state.status.isLoadedAppointment) {
              appointment = state.appointment;
            }
            return Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: AppointmentCard(
                appointment: appointment,
                action: () {
                  Navigator.pushNamed(context, RouteName.CALL_ROOM,
                      arguments:
                          CallRoomArgs(appointmentId: appointment.conAppId));
                },
              ),
            );
          }
        },
      ),
    );
  }
}
