import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/today_appointment_cubit.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/screens/call_room_screen.dart';
import 'package:expat_assistant/src/states/today_appointment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appointment_card.dart';

// ignore: must_be_immutable
class TodayAppointment extends StatefulWidget {
  bool isReload = false;

  TodayAppointment(this.isReload);
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
          if (widget.isReload == true) {
            BlocProvider.of<TodayAppointmentCubit>(context)
                .getTodayAppointment();
          }
          if (state.status.isLoadingAppointment) {
            return Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              height: SizeConfig.blockSizeVertical * 15,
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 0.5,
                ),
              ),
            );
          } else {
            if (state.status.isLoadedAppointment) {
              appointment = state.appointment;
              widget.isReload = false;
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
