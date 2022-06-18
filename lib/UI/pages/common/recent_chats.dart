import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/model.dart';
import '../../../model/objects/entity/message_count.dart';
import '../../../model/objects/message_model.dart';
import 'chat_page.dart';


class RecentChats extends StatefulWidget {

  static const String route = '/recentChatPage';
  const RecentChats({Key? key}) : super(key: key);

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {

  bool notificheOttenute = false;
  late List<MessageCount> notifications;

  @override
  void initState()
  {
    _pullData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
        title: Text("Thesis"),
      ),
      body:notificheOttenute? Column(
        children: <Widget>[
          if(notifications.length != 0)Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child:Column(
                children: <Widget>[
                  _buildRecentChat(),
                ],
              ),
            ),
          ),
        ],
      ) : _attendData(),
    );
  }

  _pullData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userEmail = sharedPreferences.getString('email')!;
    Model.sharedInstance.showUnreadChat(userEmail).then((result){
      setState((){
        notifications = result!;
        notificheOttenute = true;
      });
    });
  }

  _attendData(){
    return Padding(
        padding: const EdgeInsets.all(50),
        child:Center(child: CircularProgressIndicator()));
  }
 _buildRecentChat(){
   return Expanded(
     child: Container(
       decoration: BoxDecoration(
         color: Colors.white,
       ),
       child: ClipRRect(
         child: ListView.builder(
           itemCount: notifications.length,
           itemBuilder: (BuildContext context, int index) {
             final MessageCount chat = notifications[index];
             return GestureDetector(
               onTap: null,
               child: Container(
                 margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0, left:10.0),
                 padding:
                 EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                 decoration: BoxDecoration(
                   color: Color(0xFFFFEFEE),
                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Row(
                       children: <Widget>[
                         CircleAvatar(
                           radius: 35.0,
                           child: Text(
                             chat.sender.name.substring(0,1)+" "+chat.sender.surname.substring(0,1),
                           ),
                         ),
                         SizedBox(width: 10.0),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Text(
                               chat.sender.name +" "+ chat.sender.surname,
                               style: TextStyle(
                                 color: Colors.grey,
                                 fontSize: 15.0,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             SizedBox(height: 5.0),
                             /*Container(
                               width: MediaQuery.of(context).size.width * 0.45,
                               child: Text(
                                 chat.text,
                                 style: TextStyle(
                                   color: Colors.blueGrey,
                                   fontSize: 15.0,
                                   fontWeight: FontWeight.w600,
                                 ),
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ),*/
                           ],
                         ),
                       ],
                     ),
                     Column(
                       children: <Widget>[
                         Text(
                           chat.total.toString(),
                           style: TextStyle(
                             color: Colors.grey,
                             fontSize: 15.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 5.0),
                         Container(
                           width: 40.0,
                           height: 20.0,
                           decoration: BoxDecoration(
                             color: Theme.of(context).primaryColor,
                             borderRadius: BorderRadius.circular(30.0),
                           ),
                           alignment: Alignment.center,
                           child: Text(
                             'NEW',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 12.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
             );
           },
         ),
       ),
     ),
   );
 }
}



