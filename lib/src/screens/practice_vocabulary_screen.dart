import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';
import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:expat_assistant/src/widgets/vocabulary_practice_writing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PracticeVocabularyScreen extends StatefulWidget {
  _PracticeVocabularyState createState() => _PracticeVocabularyState();
}

class _PracticeVocabularyState extends State<PracticeVocabularyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                  child: Row(
                    children: [
                      IconButton(icon: Icon(Icons.close), onPressed: () {
                        Navigator.pop(context);
                      }),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 65,
                        height: SizeConfig.blockSizeVertical * 1,
                        child: StepProgressIndicator(
                            totalSteps: 20,
                            currentStep: 15,
                            size: 10,
                            padding: 0,
                            selectedColor: Color.fromRGBO(30, 193, 194, 30),
                            unselectedColor: Colors.grey,
                            roundedEdges: Radius.circular(10.0)),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2,),
                      Text('15/20')
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                VocabularyPracticeWriting(vietnamese: 'Thảo luận', english: 'Discuss',)
              ],
            )),
      ),
    );
  }
}
