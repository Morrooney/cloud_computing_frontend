import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/UI/pages/student/student_personal_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/dialog_window.dart';
import '../common/recent_chats.dart';

class StudentHomePage extends StatefulWidget {
  static const String route = '/studentHomePage';


  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {

  //User user;

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor:  Colors.red.shade900,
        centerTitle: true,
        title: Text("Thesis"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          ),
        ],
      ),
      drawer: new Drawer( // disegno tre stecche
        child:new ListView(
          children:<Widget>[
//          header
            Padding(padding: const EdgeInsets.all(50),child: Center(child:CircularProgressIndicator())),
//          body
            InkWell(
              onTap: null,
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(StudentProfilePage.route);
              },
              child: ListTile(
                title: Text("My account"),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap:(){
                Navigator.of(context).pushNamed(ThesisDetails.route);
              },
              child: ListTile(
                title: Text("My Thesis"),
                leading: Icon(Icons.book),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RecentChats.route);
              },
              child: ListTile(
                title: Text("Recent Chats"),
                leading: Icon(CupertinoIcons.chat_bubble_text_fill),
              ),
            ),
            Divider(),
            InkWell(
              onTap:(){
                showDialog(
                    context: context,
                    builder: (context){
                      return DialogWindow(title: "About", content: "A simple platform for \n the management of \n degree theses");;
                    });
              },
              child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.help),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(LoginPage.route);
                },
              child: ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

