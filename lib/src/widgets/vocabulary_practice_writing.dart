import 'package:expat_assistant/src/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VocabularyPracticeWriting extends StatelessWidget{
  String vietnamese, english;
  VocabularyPracticeWriting({@required this.vietnamese, @required this.english});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5, right: SizeConfig.blockSizeHorizontal * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Write the correct translation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          Text(vietnamese, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
          SizedBox(height: SizeConfig.blockSizeVertical * 2,),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Write english meaning here...',
              filled: true,
              fillColor: Colors.black12,
              focusColor: Color.fromRGBO(30, 193, 194, 30),
              focusedBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: new BorderSide(color: Colors.black12)
              ),
              enabledBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: new BorderSide(color: Colors.black12)
              ),
            ),
            minLines: 12, // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 21,),
          Center(child: Container(
            width: SizeConfig.blockSizeHorizontal * 85,
            child: CupertinoButton(
                color: Color.fromRGBO(30, 193, 194, 30),
                child: Text("Check"),
                onPressed: () {
                  //Navigator.pushNamed(context, '/practicevocabulary');
                }),
          ),),

        ],
      ),
    );
  }

}