import 'package:cloud_computing_frontend/UI/pages/common/signup_page.dart';
import 'package:cloud_computing_frontend/UI/pages/student/student_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../model/support/login_result.dart';
import '../docent/docent_home_page.dart';
import 'package:cloud_computing_frontend/UI/components/dialog_window.dart';


class LoginPage extends StatefulWidget {

  static const String route = '/login';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences _sharedPreferences;
  late LoginResult _loginResult;
  late String _email;
  late String _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _widthScreeSize = MediaQuery.of(context).size.width;
    double _heightScreenSize = MediaQuery.of(context).size.height;
    return Container(
         padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(_widthScreeSize * 0.30,_heightScreenSize * 0.15,_widthScreeSize * 0.30, _heightScreenSize * 0.15),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.red.shade900,
            width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
        child:new Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5.0, left: 0, right: 5.0),
              child:Image.asset('assets/logoUnical.png', width:300, height:200),
            ),
            Container(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),),
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Colors.red.shade900),
                        ),
                        validator: null,
                        onSaved: null,
                        onFieldSubmitted: null,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),),
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900),
                        ),
                        validator: null,
                        onSaved: null,
                        onFieldSubmitted: null,
                        obscureText: true,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                            onTap: (){
                              _docentLogin();
                              Navigator.of(context).pushNamed(DocentHomePage.route);
                            },
                            child: Container(
                              height: 40.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.red.shade900,
                                elevation: 7.0,
                                child: Center(
                                  child: Text(
                                    "docent login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),),
                          Padding(padding: EdgeInsets.all(10)),
                          Expanded(
                            child: GestureDetector(
                            onTap:  (){
                              _studentLogin();
                              Navigator.of(context).pushNamed(StudentHomePage.route);
                            },
                            child: Container(
                              height: 40.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.red.shade900,
                                elevation: 7.0,
                                child: Center(
                                  child: Text(
                                    "student login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),)
                        ],
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to the platform ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(SignupPage.route);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.red.shade900,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
          backgroundColor: Colors.white,
        ),
    );
  }

  _showErrorDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogWindow(title: title, content: message);
        });
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

  Future<void> _studentLogin() async{
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("isAStudent", true);
  }

  Future<void> _docentLogin() async{
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("isAStudent", false);
  }
 /* Future<void> _login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Processing Data'),
        duration: Duration(seconds: 1),
      ));

      await _getToken();
      switch (_loginResult) {
        case LoginResult.logged:
          {
            //print(_email);
            User user = await Model.sharedInstance.searchUserByEmail(_email);
            //print(user);
            if (user != null) {
              user.setUserPrefs();
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  new HomePage()));
            }
            else _showErrorDialog("Utente non trovato", "email o password sbagliata");
          }
          break;
        case LoginResult.error_wrong_credentials:
          {
            _showErrorDialog("WRONG CREDENTIALS", "message..");
          }
          break;
        default:
          {
            _showErrorDialog("UNKNOWN ERROR", "messagge..");
          }
          break;
      }
    }
  }

  Future<void> _getToken() async {
    LoginResult loginResult =
    await Model.sharedInstance.logIn(_email, _password);
    setState(() {
      _loginResult = loginResult;
    });
  }*/

  void checkAutoLogIn() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => new LoginPage()));
  }
}