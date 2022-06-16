import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import '../../components/circular_profile.dart';
import '../../components/row_detail.dart';



class StudentProfilePage extends StatefulWidget {

  static const String route = '/docentProfile';


  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {

  //User user;

  /*
  @override
  void initState(){
    _pullData();
    super.initState();
  }*/


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:buildAppBar(context),
      body:ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:CirculaProfile(100.0,'S','M'),
            ),
          ),
          const SizedBox(height:24),
          buildName(),
          Divider(),
          RowDetail("FirstName","name"),
          Divider(),
          RowDetail("LastName","surname"),
          Divider(),
          RowDetail("Email","email"),
          Divider(),
          RowDetail("Department","department"),
          Divider(),
          RowDetail("Degree Course","degree course"),
          Divider(),
          RowDetail("registration number","name"),
          Divider(),
        ],
      ),
    );
  }


  Widget buildName() => Column(
    children: [
      Text(
        'Stefano',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize:24),
      ),
      const SizedBox(height: 4),
      Text(
        'Morrone',
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

/*

  Future<void> _pullData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      User user1 = new User(
          firstName : sharedPreferences.getString('firstName'),
          lastName : sharedPreferences.getString('lastName'),
          address :sharedPreferences.getString('address'),
          email :sharedPreferences.getString('email'),
          telephoneNumber : sharedPreferences.getString('telephoneNumber'),
          id : sharedPreferences.getInt('id'));
      user = user1;
    });

    // print(user.toString() + "*");
  }*/
}

AppBar buildAppBar(BuildContext context)
{
  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.red.shade900,
    elevation: 0,
  );
}