import 'package:flutter/material.dart';


class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const CircularIconButton({required Key key, required this.icon, required this.onPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(3),
        child: RawMaterialButton(
          onPressed: null,
          elevation: 2.0,
          fillColor: Colors.green,
          child: Icon(icon, color: Colors.white),
          padding: EdgeInsets.all(10.0),
          shape: CircleBorder(),
        )
    );
  }


}