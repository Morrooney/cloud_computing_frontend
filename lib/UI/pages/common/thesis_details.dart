import 'dart:html';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_computing_frontend/UI/components/supervisors_list.dart';
import 'package:cloud_computing_frontend/UI/pages/common/docent_page_chat.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/objects/entity/thesis.dart';
import '../../components/circular_profile.dart';
import '../../components/dialog_window.dart';
import 'dropped_file_page.dart';
import 'files_page.dart';


class ThesisDetails extends StatefulWidget {

  static const String route = '/thesisDetails';

  @override
  _ThesisDetailsState createState() => _ThesisDetailsState();
}

class _ThesisDetailsState extends State<ThesisDetails> {


 String userEmail = '';
 late Thesis thesis;

 @override
 void initState(){
   _pullData();
   super.initState();
 }

  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    thesis = Thesis.fromJson(args);


    return (userEmail == '')? CircularProgressIndicator() :Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red.shade700,
      ),
      body:new ListView(
        children: <Widget> [
          _buildSectionTitle("Thesis Details"),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
                child: new Text(
                    "Title",
                    style: TextStyle(color: Colors.grey)
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new Text("${thesis.title}")
              ),
            ],
          ),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
                child: new Text(
                    "type",
                    style: TextStyle(color: Colors.grey)
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new Text("${thesis.type}")
              ),
            ],
          ),
          Divider(),
          _buildSectionTitle("Main Supervisor"),
          Divider(),
          Container(
            height: 165,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
                  child:
                  InkWell(
                    borderRadius: BorderRadius.circular(75),
                    onTap: (userEmail != thesis.mainSupervisor.email)? (){
                      Navigator.of(context).pushNamed(DocentProfileChatPage.route);
                    }:null,
                    child: CirculaProfile(75.0,"${thesis.mainSupervisor.name}",'${thesis.mainSupervisor.surname}'),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          if(thesis.supervisors?.length != 0 ) _buildSupervisorsSection(),
          _buildSectionTitle("Thesis student"),
          Divider(),
          Container(
            height: 165,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
                  child:
                  InkWell(
                    borderRadius: BorderRadius.circular(75),
                    onTap: (userEmail == thesis.thesisStudent.email)? null:(){
                      Navigator.of(context).pushNamed(DocentProfileChatPage.route);
                    },
                    child: CirculaProfile(75.0,'${thesis.thesisStudent.name}','${thesis.thesisStudent.surname}'),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          _buildSectionTitle("Thesis Files"),
          Divider(),
          _buildCard(),
        ],
      ),
    );
  }


  _buildSupervisorsSection(){
     return Column(
       children: [
         _buildSectionTitle("Supervisors"),
         Divider(),
         Row(
           children: [
             SupervisorsList(supervisors: thesis.supervisors,userEmail: userEmail),
             if(userEmail == thesis.mainSupervisor.email)  _buildButtomToAddUser(),
           ],
         ),
         Divider(),
       ],
     );
  }

  _buildButtomToAddUser(){
   return Padding(
     padding: const EdgeInsets.fromLTRB(25,10.0, 10.0, 5.0),
     child: FloatingActionButton(
       backgroundColor: Colors.red.shade900,
       onPressed:(){
         showDialog(
             context: context,
             builder: (context) {
               return _buildAlertInteraction();
             });
       },
       tooltip: 'Increment Counter',
       child: const Icon(Icons.add),
     ),
   );
  }

  _buildCard(){
    return Container(
      height: 80,
      width: 80,
      child: Card(
        color: Colors.white,
        semanticContainer: true,
        margin: EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 4.0),
        elevation: 3,
        child: ListTile(
          leading: InkWell(
            onTap: null,
            child: new Icon(
              Icons.folder,
              size: 45,
            ),
          ),
          title: new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text("Thesis files"),
          ),
          subtitle: new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
            child: new Text(
              "All thesis files ",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ),
          trailing: new FittedBox(
            fit: BoxFit.fill,
            child: new Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.arrow_circle_right_outlined),
                  onPressed: (){
                    Navigator.of(context).pushNamed(FilesPage.route);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSectionTitle(String text){
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
      child: new Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 50,
        ),
      ),
    );
  }

  _buildAlertInteraction(){
    return new AlertDialog(
      title: new Text(
        "Insert docent email",
        textAlign: TextAlign.center,
      ),
      content: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),),
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color:Colors.red.shade900),
        ),
        validator: null,
        onSaved: null,
        onFieldSubmitted: null,
      ),
      actions: <Widget>[
        new MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: new Text(
            "select",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
        ),
        new MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: new Text(
            "close",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
        ),
      ],
    );
  }
 Future<void> _pullData() async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   setState((){
     userEmail = sharedPreferences.getString("email")!;
   });
 }

}


