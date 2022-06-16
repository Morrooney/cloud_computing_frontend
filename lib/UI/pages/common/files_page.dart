import 'package:cloud_computing_frontend/UI/components/thesis_files.dart';
import 'package:cloud_computing_frontend/UI/pages/common/dropped_file_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class FilesPage extends StatefulWidget {
  static const String route = '/filePage';


  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {

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
        title: Text("Files"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: null
          ),
        ],
      ),
      body: ThesisFiles(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade900,
        onPressed:(){
          Navigator.of(context).pushNamed(DropFilePage.route);
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

}

