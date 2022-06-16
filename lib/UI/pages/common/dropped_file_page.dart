import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../model/objects/file_data_model.dart';
import '../../components/drop_zone_widget.dart';
import '../../components/dropped_file_widget.dart';

class DropFilePage extends StatefulWidget {

  static const String route = '/dropFilePage';
  const DropFilePage({Key? key}) : super(key: key);

  @override
  _DropFilePageState createState() => _DropFilePageState();
}

class _DropFilePageState extends State<DropFilePage> {

  late bool _isAStudent = false;
  File_Data_Model? file;

  @override
  void initState(){
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
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [

                SizedBox(height: 20,),
                Row(
                  children:[
                    _isAStudent? Text("Select the docent that you want to notify"):
                    Text("Select the student that you want to notify"),
                  ]
                ),

                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  height: 70.0,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {},
                          decoration: InputDecoration.collapsed(
                            hintText: 'Write the email',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                Row(
                  children: [
                    Text("Write the message"),
                  ],
                ),

                SizedBox(height: 20,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  height: 70.0,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {},
                          decoration: InputDecoration.collapsed(
                            hintText: 'text ...',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  height: 300,
                  child: DropZoneWidget(
                    onDroppedFile: (file) => setState(()=> this.file = file) ,
                  ),
                ),
                SizedBox(height: 20,),
                DroppedFileWidget(file:file ),

                SizedBox(height: 20,),

                GestureDetector(
                  onTap: null,
                  child: Container(
                    height: 80.0,
                    width: 250.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.red.shade900,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          "Add file",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            )),
      ),
    );
  }

  Future<void> _pullData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState((){
      _isAStudent = sharedPreferences.getBool("isAStudent")??false;
    });
  }
}
