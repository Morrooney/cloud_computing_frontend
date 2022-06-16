import 'dart:js';


import 'package:cloud_computing_frontend/UI/pages/docent/docent_home_page.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/docent_personal_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/docent_page_chat.dart';
import 'package:cloud_computing_frontend/UI/pages/common/dropped_file_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/files_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/UI/pages/student/student_home_page.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/student_registration_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/theses_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/thesis_registration_page.dart';
import 'package:cloud_computing_frontend/model/objects/message_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:universal_html/html.dart';

import 'UI/pages/common/chat_page.dart';
import 'UI/pages/common/recent_chats.dart';
import 'UI/pages/common/signup_page.dart';

void main() {

  setUrlStrategy(PathUrlStrategy());
  runApp(
    MaterialApp(
      title: 'Thesis',
      initialRoute: LoginPage.route,
      debugShowCheckedModeBanner: false,
      routes:{
        LoginPage.route: (context) =>  LoginPage(),
        SignupPage.route: (context) => SignupPage(),
        StudentHomePage.route: (context) => StudentHomePage(),
        DocentHomePage.route: (context) => DocentHomePage(),
        DocentProfilePage.route: (context) => DocentProfilePage(),
        ThesisDetails.route: (context) => ThesisDetails(),
        AddStudentPage.route: (context) => AddStudentPage(),
        DocentProfileChatPage.route: (context) => DocentProfileChatPage(),
        FilesPage.route: (context) => FilesPage(),
        ChatPage.route: (context) => ChatPage(user: chats[0].sender),
        ThesesPage.route:(context) => ThesesPage(),
        AddThesisPage.route: (context) => AddThesisPage(),
        DropFilePage.route: (context) => DropFilePage(),
        RecentChats.route: (context) => RecentChats(),
      }
    ),
  );
}
