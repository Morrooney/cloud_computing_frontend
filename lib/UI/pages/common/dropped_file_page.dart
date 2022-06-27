import 'package:cloud_computing_frontend/model/objects/entity/thesis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../model/model.dart';
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
  FileDataModel? _file;
  late Thesis _thesis;
  late String _userEmail;
  late String _text;
  late String _receiverEmail;
  final _textController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState(){
    _pullData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    _thesis = Thesis.fromJson(args);

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
                        child: TextFormField(
                          controller: _emailController,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            _receiverEmail = value;
                          },
                          onFieldSubmitted: (value) {
                            _receiverEmail = value;
                          },
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
                        child: TextFormField(
                          controller: _textController,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            _text = value;
                          },
                          onFieldSubmitted: (value) {
                            _text = value;
                          },
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
                    onDroppedFile: (file) => setState(()=> this._file = file) ,
                  ),
                ),
                SizedBox(height: 20,),
                DroppedFileWidget(file:_file ),

                SizedBox(height: 20,),

                GestureDetector(
                  onTap: (){
                    _sendMessage();
                    _uploadFile();
                    },
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
      _userEmail = sharedPreferences.getString("email")!;
      _isAStudent = sharedPreferences.getBool("isAStudent")??false;
    });
  }

  _sendMessage() async{
    Model.sharedInstance.sendMessage(_userEmail,_receiverEmail,_text).then((value){
      _textController.clear();
      _emailController.clear();
    });
  }

  _uploadFile() async{
    Model.sharedInstance.uploadFiles(_userEmail,_thesis.id,1,_file).then((result){
      print(result!.statusCode.toString());
    });
  }

}
