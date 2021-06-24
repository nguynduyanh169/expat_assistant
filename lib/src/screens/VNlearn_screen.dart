import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/cubits/vn_learn_cubit.dart';
import 'package:expat_assistant/src/models/hive_object.dart';
import 'package:expat_assistant/src/models/topic.dart';
import 'package:expat_assistant/src/repositories/conversation_repository.dart';
import 'package:expat_assistant/src/repositories/topic_repository.dart';
import 'package:expat_assistant/src/screens/conversation_details_screen.dart';
import 'package:expat_assistant/src/states/vn_learn_state.dart';
import 'package:expat_assistant/src/widgets/lesson_card.dart';
import 'package:expat_assistant/src/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class VNlearnScreen extends StatefulWidget {
  _VNlearnScreenState createState() => _VNlearnScreenState();
}

class _VNlearnScreenState extends State<VNlearnScreen> {
  List<LessonLocal> _lessons;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 244, 244, 2),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black38,
              height: 0.25,
            ),
            preferredSize: Size.fromHeight(0.25)),
        elevation: 0.5,
        backgroundColor: Colors.white,
        toolbarHeight: SizeConfig.blockSizeVertical * 10,
        //leadingWidth: SizeConfig.blockSizeHorizontal * 10,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Learn Vietnamese',
          style: GoogleFonts.lato(fontSize: 22, color: Colors.black),
        ),
        actions: [
          InkWell(
            child: Icon(CupertinoIcons.search),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          )
        ],
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => VNlearnCubit(TopicRepository(), ConversationRepository())..getAllTopic(),
        child: BlocBuilder<VNlearnCubit, VNlearnState>(
          builder: (context, state){
            if(state.status.isLoadFailed){
              return Container();
            }else if(state.status.isLoading){
              return LoadingView(message: 'Loading lessons...');
            }else{
              if(state.status.isLoadSuccess) {
                _lessons = state.lessonLocalList;
              }
              return Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                child: ListView.separated(
                  itemCount: _lessons.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  itemBuilder: (context, index) => LessonCard(
                    title: _lessons[index].name,
                    description: _lessons[index].des,
                    image: _lessons[index].imageLink,
                    downloadConversation: (){
                      BlocProvider.of<VNlearnCubit>(context).downloadConversation(_lessons[index].id);
                    },
                    vocabularyAction: () {
                      Navigator.pushNamed(context, '/vocabularyDetails');
                    },
                    conversationAction: (){
                      Navigator.pushNamed(context, '/conversationDetails', arguments: ConversationDetailScreenArguments(_lessons[index].conversations, _lessons[index].name));
                    },
                    conversations: _lessons[index].conversations,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
