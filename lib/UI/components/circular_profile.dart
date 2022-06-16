import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class CirculaProfile extends StatelessWidget {
  const CirculaProfile(this.radius, this.initialLetterName,this.initialLetterSurname) : super();

  final double radius;
  final String initialLetterName;
  final String initialLetterSurname;

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      '',
      radius: radius,
      backgroundColor: Colors.red.shade700,
      borderWidth: 2,
      initialsText: Text(
        initialLetterName+initialLetterSurname,
        style: TextStyle(color:Colors.red.shade100,
            fontWeight: FontWeight.bold,
            fontFamily: 'QuickSand',
            fontSize: 70
        ),
      ),
      borderColor: Colors.red.shade900,
    );
  }
}
