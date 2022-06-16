import 'package:flutter/material.dart';

import '../../components/page_title.dart';

class AddStudentPage extends StatefulWidget {
  static const String route = '/addStudent';
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {



  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return SafeArea(
        child: new Scaffold(
            appBar: new AppBar(
              elevation: 0.1,
              backgroundColor: Colors.red.shade700,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    PageTitle('Add Student'),
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                    Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              _buildTextForm('name'),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              _buildTextForm('surname'),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              _buildTextForm('email'),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              _buildTextForm('registration number'),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              _buildTextForm('degree course'),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              _buildTextForm('department'),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              GestureDetector(
                                onTap:null,
                                child: Container(
                                  height: 40.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.red.shade900,
                                    elevation: 7.0,
                                    child: Center(
                                      child: Text("register",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )));
  }

  _buildTextForm(String text){
    return TextFormField(
      decoration: InputDecoration(
        //border: OutlineInputBorder(),
        labelText: text,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900),
      ),
      validator: null,
      onSaved: null,
    );
  }
/*
  _validateRequired(String value) {
    if (value.isEmpty || value == null)
      return "required";
    else
      return null;
  }

  _validateEmail(String value) {
    if (value.isEmpty || value == null) {
      return "required";
    }
    return null;
  }

  _validatePassword(String value) {
    if (value.isEmpty || value == null)
      return "required";
    else if (value.length < 6)
      return "pwd_min_6_char";
    else if (value.length > 15)
      return "pwd_max_25_char";
    else
      return null;
  }

  Future<void> _signup() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Processing Data'),
        duration: Duration(seconds: 1),
      ));

      User newUser = new User(
          firstName: _firstName,
          lastName: _lastName,
          telephoneNumber: _telephoneNumber,
          email: _email,
          address: _address);
      User created = await Model.sharedInstance.newUser(newUser, _password);
      if (created == null)
        _errorDialog("UNKWOWN ERROR");
      else {
        _successDialog("registered");
      }
    }
  }


  _errorDialog(String title) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "UNKWOWN ERROR",
        backgroundColor: Colors.green,
        confirmBtnColor: Colors.lightGreen,
        onConfirmBtnTap: () => Navigator.pop(context));
  }

  _successDialog(String title) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title:
        "registered",
        backgroundColor: Colors.green,
        confirmBtnColor: Colors.lightGreen,
        onConfirmBtnTap: () =>
        {Navigator.pop(context), Navigator.pop(context)});
  }
  */
}