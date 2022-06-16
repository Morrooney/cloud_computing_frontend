import 'package:cloud_computing_frontend/UI/components/dialog_window.dart';
import 'package:cloud_computing_frontend/UI/pages/common/recent_chats.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/docent_personal_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/student_registration_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/theses_page.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/thesis_registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocentHomePage extends StatefulWidget {
  static const String route = '/docentHomePage';

  @override
  _DocentHomePageState createState() => _DocentHomePageState();
}

class _DocentHomePageState extends State<DocentHomePage> {
  //User user;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
        title: Text("Thesis"),
      ),
      drawer: _buildMenu(),
    );
  }

  _buildMenu(){
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(50),
              child: Center(child: CircularProgressIndicator())),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(DocentProfilePage.route);
            },
            child: ListTile(
              title: Text("My account"),
              leading: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ThesesPage.route);
            },
            child: ListTile(
              title: Text("My Theses"),
              leading: Icon(Icons.book),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AddStudentPage.route);
            },
            child: ListTile(
              title: Text("Add Student"),
              leading: Icon(Icons.add_circle),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AddThesisPage.route);
            },
            child: ListTile(
              title: Text("Add Thesis"),
              leading: Icon(Icons.add_circle_outline),
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
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWindow(title: "About", content: "A simple platform for \n the management of \n degree theses");
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
    );
  }


}
