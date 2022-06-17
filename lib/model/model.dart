import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:cloud_computing_frontend/model/objects/entity/student.dart';
import 'package:cloud_computing_frontend/model/objects/entity/thesis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_computing_frontend/model/support/constants.dart';
import 'package:cloud_computing_frontend/model/support/login_result.dart';
import 'package:cloud_computing_frontend/model/objects/authentication_data.dart';
import 'managers/rest_manager.dart';
import 'objects/authentication_data.dart';
import 'objects/entity/docent.dart';
import 'package:http/http.dart';

class Model{
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  late AuthenticationData _authenticationData;
  late SharedPreferences _sharedPreferences;


  Future<Docent?> newDocent(String email, String pwd) async {
    Map<String, String> params = Map();
    params["docent_email"] = email;
    params["pwd"] = pwd;
    try {
      Response response = await _restManager.makePostRequest(
          ADDRESS_STORE_SERVER, REQUEST_NEW_DOCENT, null,
          value: params);
      if (response.statusCode == HttpStatus.created) {
        return Docent.fromJson(json.decode(response.body));
      } else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future<Student?> newStudent(String email, String pwd) async {
    Map<String, String> params = Map();
    params["student_email"] = email;
    params["pwd"] = pwd;
    try {
      Response response = await _restManager.makePostRequest(
          ADDRESS_STORE_SERVER, REQUEST_NEW_STUDENT, null,
          value: params);
      if (response.statusCode == HttpStatus.created) {
        return Student.fromJson(json.decode(response.body));
      } else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future<LoginResult> logIn(String email, String password) async {
    try{
      Map<String, dynamic> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = CLIENT_ID;
      params["client_secret"] = CLIENT_SECRET;
      params["username"] = email;
      params["password"] = password;
      String result = (await _restManager.makePostRequest(ADDRESS_AUTHENTICATION_SERVER, REQUEST_LOGIN, params, type: TypeHeader.urlencoded)).body;
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        if ( _authenticationData.error == "Invalid user credentials" ) {
          return LoginResult.error_wrong_credentials;
        }
        else if ( _authenticationData.error == "Account is not fully set up" ) {
          return LoginResult.error_not_fully_setupped;
        }
        else {
          return LoginResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData.accessToken;
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setString('token', _authenticationData.accessToken!);
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn! - 50)), (Timer t) {
        _refreshToken();
      });
      return LoginResult.logged;
    }
    catch (e) {
      print(e);
      return LoginResult.error_unknown;
    }
  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, dynamic> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = CLIENT_ID;
      params["client_secret"] = CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken;
      String result = (await _restManager.makePostRequest(ADDRESS_AUTHENTICATION_SERVER, REQUEST_LOGIN, params, type: TypeHeader.urlencoded)).body;
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        return false;
      }
      _restManager.token = _authenticationData.accessToken;
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setString('token', _authenticationData.accessToken!);
      return true;
    }
    catch (e) {
      return false;
    }
  }



  Future<Student?> searchStudentByEmail(String email) async {
    Map<String, dynamic> params = Map();
    params["student_email"] = email;
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER, REQUEST_SEARCH_STUDENT_BY_EMAIL, params);
      //print(response.body.toString());
      if( response.statusCode == HttpStatus.notFound )return null;
      return Student.fromJson(jsonDecode(response.body));
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<Docent?> searchDocentByEmail(String email) async {
    Map<String, dynamic> params = Map();
    params["docent_email"] = email;
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER, REQUEST_SEARCH_DOCENT_BY_EMAIL, params);
      //print(response.body.toString());
      if( response.statusCode == HttpStatus.notFound )return null;
      return Docent.fromJson(jsonDecode(response.body));
    }
    catch (e) {
      print(e);
      return null;
    }
  }


  Future<List<Thesis>?> showDocentThesis(String docentEmail) async {
    Map<String, String> params = Map();
    params["docent_email"] = docentEmail;
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER, REQUEST_SHOW_DOCENT_THESES, params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      List<Thesis> result =  List<Thesis>.from(json.decode(response.body).map((i) => Thesis.fromJson(i)).toList());
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<Thesis?> showStudentThesis(String docentEmail) async {
    Map<String, String> params = Map();
    params["student_email"] = docentEmail;
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER, REQUEST_SHOW_STUDENT_THESES, params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      Thesis result = Thesis.fromJson(json.decode(response.body));
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

/*
  Future<bool> logOut() async {
    try{
      Map<String, dynamic> params = Map();
      _restManager.token = null;
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setString('token', null);
      params["client_id"] = CLIENT_ID;
      params["client_secret"] = CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken;
      await _restManager.makePostRequest(ADDRESS_AUTHENTICATION_SERVER, REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }*/
}