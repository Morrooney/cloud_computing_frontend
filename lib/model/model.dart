import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:cloud_computing_frontend/model/objects/entity/message_count.dart';
import 'package:cloud_computing_frontend/model/objects/entity/student.dart';
import 'package:cloud_computing_frontend/model/objects/entity/thesis.dart';
import 'package:cloud_computing_frontend/model/objects/entity/message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_computing_frontend/model/support/constants.dart';
import 'package:cloud_computing_frontend/model/support/login_result.dart';
import 'package:cloud_computing_frontend/model/objects/authentication_data.dart';
import 'managers/rest_manager.dart';
import 'objects/authentication_data.dart';
import 'objects/entity/docent.dart';
import 'package:http/http.dart';
import 'package:cloud_computing_frontend/model/objects/entity/file.dart';

import 'objects/file_data_model.dart';

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
      print(result.toString());
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


  Future<void> downloadFile(int fileId) async {
    Map<String, dynamic> params = Map();
    params["id"] = fileId.toString();
    Uri uri = Uri.http(ADDRESS_STORE_SERVER, REQUEST_DOWNLOAD_FILE, params);
    AnchorElement anchorElement =  new AnchorElement(href: uri.toString());
    anchorElement.download = uri.toString();
    anchorElement.click();
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
      print("response "+ response.headers.toString());
      if( response.statusCode == HttpStatus.notFound ) return null;
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
      if( response.body.isEmpty) return null;
      Thesis result = Thesis.fromJson(json.decode(response.body));
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<MessageCount>?> showUnreadChat(String receiverEmail) async {
    Map<String, String> params = Map();
    params["receiver_email"] = receiverEmail;
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER, REQUEST_SHOW_UNREAD_MESSAGE, params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      List<MessageCount> result =  List<MessageCount>.from(json.decode(response.body).map((i) => MessageCount.fromJson(i)).toList());
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Docent>?> searchDocent(String docentEmail) async {
    Map<String, String> params = Map();
    params["docent_email"] = docentEmail;
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER, REQUEST_SEARCH_DOCENT, params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      List<Docent> result =  List<Docent>.from(json.decode(response.body).map((i) => Docent.fromJson(i)).toList());
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Student>?> searchStudent(String studentEmail) async {
    Map<String, String> params = Map();
    params["student_email"] = studentEmail;
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER, REQUEST_SEARCH_STUDENT, params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      List<Student> result =  List<Student>.from(json.decode(response.body).map((i) => Student.fromJson(i)).toList());
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> sendMessage(String senderEmail,String receiverEmail, String text) async {
    Map<String, String> params = Map();
    params["sender_email"] = senderEmail;
    params["receiver_email"] = receiverEmail;
    String body = text;
    try{
      Response response = await _restManager.makePostRequest(ADDRESS_STORE_SERVER,REQUEST_SEND_MESSAGE,body,value:params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<Thesis?> addThesis(String studentEmail,String docentEmail, String thesisTitle, String thesisType) async {
    Map<String, String> params = Map();
    params["student_email"] = studentEmail;
    params["docent_email"] = docentEmail;
    params["thesis_title"] = thesisTitle;
    params["thesis_type"] = thesisType;
    try{
      Response response = await _restManager.makePostRequest(ADDRESS_STORE_SERVER,REQUEST_ADD_NEW_THESIS,null,value:params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      Thesis thesis = Thesis.fromJson(json.decode(response.body));
      return thesis;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<Docent?> addDocent(Docent docent) async {
    try{
      Response response = await _restManager.makePostRequest(ADDRESS_STORE_SERVER,REQUEST_ADD_NEW_DOCENT,docent.toJson());
      if( response.statusCode == HttpStatus.notFound ) return null;
      Docent docentResponse = Docent.fromJson(json.decode(response.body));
      return docentResponse;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<Student?> addStudent(Student student) async {
    try{
      print(student.toJson());
      Response response = await _restManager.makePostRequest(ADDRESS_STORE_SERVER,REQUEST_ADD_NEW_STUDENT,student.toJson());
      if( response.statusCode == HttpStatus.notFound ) return null;
      Student studentResponse = Student.fromJson(json.decode(response.body));
      return studentResponse;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<Thesis?> addSupervisor(String docentEmail,int thesisId, String supervisorEmail) async {
    Map<String, String> params = Map();
    params["docent_email"] = docentEmail;
    params["thesis_id"] = thesisId.toString();
    params["supervisor_email"] = supervisorEmail;
    try{
      Response response = await _restManager.makePostRequest(ADDRESS_STORE_SERVER,REQUEST_ADD_SUPERVISOR,null,value:params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      Thesis thesis = Thesis.fromJson(json.decode(response.body));
      return thesis;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Message>?> showAllMessages(String user1Email,String user2Email) async {
    Map<String, String> params = Map();
    params["user1_email"] = user1Email;
    params["user2_email"] = user2Email;
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER, REQUEST_SHOW_MESSAGES_CONVERSATION, params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      List<Message> result =  List<Message>.from(json.decode(response.body).map((i) => Message.fromJson(i)).toList());
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<File>?> getThesisFiles(int thesisId) async {
    Map<String, String> params = Map();
    params["thesis_id"] = thesisId.toString();
    try{
      Response response = await _restManager.makeGetRequest(ADDRESS_STORE_SERVER,REQUEST_SHOW_ALL_THESIS_FILES,params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      List<File> result =  List<File>.from(json.decode(response.body).map((i) => File.fromJson(i)).toList());
      return result;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<StreamedResponse?> uploadFiles(String ownerEmail,int thesisId, int messageId, FileDataModel? files) async{
    late StreamedResponse response;
    Map<String, String> params = Map();
    params["owner"] = ownerEmail;
    params["thesis"] = thesisId.toString();
    params["message"] = messageId.toString();
    try {
      response = await _restManager.makeMultiPartRequest(
          ADDRESS_STORE_SERVER, REQUEST_UPLOAD_FILE,files, value: params);
    }catch(e){
      print("uploadFiles exception: "+e.toString());
      return null;
    }
    return response;
  }

  Future<Response> logout(String refreshToken) async {
    Map<String, dynamic> params = Map();
    _restManager.token = null;
    // _persistentStorageManager.setString('token', null);
    params["client_id"] = CLIENT_ID;
    params["client_secret"] = CLIENT_SECRET;
    params["refresh_token"] = refreshToken;
    Response response = await _restManager.makePostRequest(
        ADDRESS_AUTHENTICATION_SERVER, REQUEST_LOGOUT, params,
        type: TypeHeader.urlencoded, httpsEnabled: false);
    return response;
  }



}