import 'package:cloud_computing_frontend/UI/components/theses_cards.dart';
import 'package:cloud_computing_frontend/UI/components/thesis_files.dart';
import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/thesis_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class ThesesPage extends StatefulWidget {
  static const String route = '/DocentTheses';


  @override
  _ThesesPageState createState() => _ThesesPageState();
}

class _ThesesPageState extends State<ThesesPage> {

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
      ),
      body: ThesesCards(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade900,
        onPressed:(){
          Navigator.of(context).pushNamed(AddThesisPage.route);
        },
        tooltip: 'Add Thesis',
        child: const Icon(Icons.add),
      ),
    );
  }

}

