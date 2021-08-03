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

// ignore: must_be_immutable
class UpcomingAppointmentScreen extends StatelessWidget {
  Appointment appointment;
  List<Appointment> appointments;
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
                        Navigator.pushNamed(context, RouteName.CALL_ROOM);
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
                      'Future appointments',
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 99, 99, 30)),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Expanded(
                      child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2),
                      child: AppointmentCard(
                        appointment: appointments[index],
                        action: () {
                          Navigator.pushNamed(context, RouteName.CALL_ROOM);
                        },
                      ),
                    ),
                    itemCount: appointments.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                  ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
