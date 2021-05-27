import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';

class VocabularyPracticeListening extends StatefulWidget {
  String vietnamese, english;

  VocabularyPracticeListening(
      {@required this.vietnamese, @required this.english});

  _VocabularyPracticeListeningState createState() =>
      _VocabularyPracticeListeningState(vietnamese, english);
}

class _VocabularyPracticeListeningState
    extends State<VocabularyPracticeListening> {
  String _vietnamese, _english;

  _VocabularyPracticeListeningState(this._vietnamese, this._english);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Listen and correct the vocabulary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Row(
            children: <Widget>[
              
            ],
          )
        ],
      ),
    );
  }
}
