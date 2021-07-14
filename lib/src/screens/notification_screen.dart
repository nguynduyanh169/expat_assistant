import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget{
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelStyle: GoogleFonts.lato(color: Colors.black),
            unselectedLabelStyle: GoogleFonts.lato(color: Colors.black),
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: 'Consultant'),
                  Tab(text: 'Event'),
                  Tab(text: 'Wallet'),
                ],
              ),
          elevation: 0.5,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Notification',
            style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
          ),
        ),
    
      ),
    );
  }
}