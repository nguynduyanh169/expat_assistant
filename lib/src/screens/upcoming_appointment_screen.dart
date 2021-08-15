import 'dart:math';

import 'package:expat_assistant/src/configs/constants.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/upcoming_appointment_cubit.dart';
import 'package:expat_assistant/src/models/appointment.dart';
import 'package:expat_assistant/src/repositories/appointment_repository.dart';
import 'package:expat_assistant/src/states/upcoming_appointment_state.dart';
import 'package:expat_assistant/src/widgets/appointment_card.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'call_room_screen.dart';

// ignore: must_be_immutable
class UpcomingAppointmentScreen extends StatelessWidget {
  ExpatAppointment appointment;
  List<ExpatAppointment> appointments;
  _DataSource events;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          UpcomingAppointmentCubit(AppointmentRepository())..getAppointments(),
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black38,
                height: 0.25,
              ),
              preferredSize: Size.fromHeight(0.25)),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.MAIN_COLOR,
          automaticallyImplyLeading: true,
          title: Text(
            'Appointments',
            style: GoogleFonts.lato(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<UpcomingAppointmentCubit, UpcomingAppointmentState>(
          builder: (context, state) {
            if (state.status.isLoadingAppointments) {
              return LoadingView(message: 'Loading...');
            }
            if (state.status.isLoadedAppointments) {
              appointment = state.todayAppointment;
              appointments = state.appointments;
              events = _DataSource(setupAppointments(appointments));
            }
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      'Upcoming appointment',
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2,
                        right: SizeConfig.blockSizeHorizontal * 2),
                    child: AppointmentCard(
                      appointment: appointment,
                      action: () {
                        Navigator.pushNamed(context, RouteName.CALL_ROOM,
                            arguments: CallRoomArgs(
                                appointmentId: appointment.conAppId));
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      'My Schedule',
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 52,
                    child: SfCalendar(
                      backgroundColor: Color.fromRGBO(244, 244, 244, 100),
                      showDatePickerButton: true,
                      scheduleViewMonthHeaderBuilder:
                          (BuildContext buildContext,
                              ScheduleViewMonthHeaderDetails details) {
                        final String monthName =
                            _getMonthDate(details.date.month);
                        return Stack(
                          children: [
                            Image(
                                image:
                                    AssetImage('assets/images/$monthName.png'),
                                fit: BoxFit.cover,
                                width: details.bounds.width,
                                height: details.bounds.height),
                            Positioned(
                              left: 55,
                              right: 0,
                              top: 20,
                              bottom: 0,
                              child: Text(
                                monthName + ' ' + details.date.year.toString(),
                                style: GoogleFonts.lato(fontSize: 18),
                              ),
                            )
                          ],
                        );
                      },
                      view: CalendarView.schedule,
                      scheduleViewSettings: ScheduleViewSettings(
                        appointmentTextStyle: GoogleFonts.lato(fontSize: 13),
                      ),
                      dataSource: events,
                      appointmentTimeTextFormat: 'kk:mm',
                      onTap: (CalendarTapDetails details) {
                        if (details.targetElement ==
                            CalendarElement.appointment) {
                          Navigator.pushNamed(context, RouteName.CALL_ROOM,
                              arguments: CallRoomArgs(
                                  appointmentId: details.appointments[0].id));
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getMonthDate(int month) {
    if (month == 01) {
      return 'January';
    } else if (month == 02) {
      return 'February';
    } else if (month == 03) {
      return 'March';
    } else if (month == 04) {
      return 'April';
    } else if (month == 05) {
      return 'May';
    } else if (month == 06) {
      return 'June';
    } else if (month == 07) {
      return 'July';
    } else if (month == 08) {
      return 'August';
    } else if (month == 09) {
      return 'September';
    } else if (month == 10) {
      return 'October';
    } else if (month == 11) {
      return 'November';
    } else {
      return 'December';
    }
  }

  List<Appointment> setupAppointments(List<ExpatAppointment> appointments) {
    List<Appointment> result = [];
    for (ExpatAppointment expatAppointment in appointments) {
      DateTime startTime = DateTime(
          expatAppointment.session.startTime[0],
          expatAppointment.session.startTime[1],
          expatAppointment.session.startTime[2],
          expatAppointment.session.startTime[3],
          expatAppointment.session.startTime[4]);
      DateTime endTime = DateTime(
          expatAppointment.session.endTime[0],
          expatAppointment.session.endTime[1],
          expatAppointment.session.endTime[2],
          expatAppointment.session.endTime[3],
          expatAppointment.session.endTime[4]);
      Color appointmentColor = Colors.blue;
      if (expatAppointment.status == 2) {
        appointmentColor = Colors.green;
      }
      if (expatAppointment.status == 0 && startTime.isBefore(DateTime.now())) {
        appointmentColor = Colors.grey;
      }
      if (expatAppointment.status == 1 && startTime.isBefore(DateTime.now())) {
        appointmentColor = Colors.grey;
      }
      result.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          color: appointmentColor,
          isAllDay: false,
          id: expatAppointment.conAppId,
          subject:
              'Appointment with Dr. ${expatAppointment.session.specialist.fullname}'));
    }
    return result;
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
