import 'package:flutter/material.dart';
import 'package:itechon/common/textfield_with_title.dart';
class TeamScoreWidget extends StatelessWidget {
  final team=TextEditingController();
  final score=TextEditingController();
  TeamScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        textFormFieldWithTitle(title: "Team",hint: "Team Name",controller: team),
        textFormFieldWithTitle(title: "Score",hint: "Team Score",controller: score),
      ],
    );
  }
}