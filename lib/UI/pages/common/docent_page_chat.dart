import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_computing_frontend/UI/pages/common/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/row_detail.dart';



class DocentProfileChatPage extends StatefulWidget {

  static const String route = '/docentProfilewithChat';


  @override
  _DocentProfileChatPageState createState() => _DocentProfileChatPageState();
}

class _DocentProfileChatPageState extends State<DocentProfileChatPage> {

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
              child:CircularProfileAvatar(
                '',
                radius: 100,
                backgroundColor: Colors.red.shade700,
                borderWidth: 2,
                initialsText: Text(
                  'S' + 'M',
                  style: TextStyle(color:Colors.red.shade100,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QuickSand',
                      fontSize: 70
                  ),
                ),
                borderColor: Colors.red.shade900,
              ),
            ),
          ),
          const SizedBox(height:24),
          buildName(),
          Divider(),
          Row(
            children: [
              Expanded(
                child: new IconButton(
                  icon: new Icon(CupertinoIcons.chat_bubble_text),
                  onPressed: (){
                    Navigator.of(context).pushNamed(ChatPage.route);
                  },
                ),
              ),
            ],
          ),
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
          RowDetail("Card number","name"),
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