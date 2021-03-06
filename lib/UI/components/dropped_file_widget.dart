import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/objects/file_data_model.dart';



class DroppedFileWidget extends StatelessWidget {

  final FileDataModel? file;
  const DroppedFileWidget({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: buildImage(context)),
      ],
    );
  }

  Widget buildImage(BuildContext context){

    if (file == null) return buildEmptyFile('No Selected File');

    print(file!.url);

    return Column(
      children: [
        if(file != null) buildFileDetail(file),
        Image.network(file!.url,
          width: MediaQuery.of(context).size.width ,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          errorBuilder:(context,error,_)=>buildEmptyFile('No Preview'),
        ),
      ],
    );
  }

  Widget buildEmptyFile(String text){
    return Container(
      width: 120,
      height: 120,
      color: Colors.red.shade400,
      child: Center(child: Text(text)),
    );
  }

  Widget buildFileDetail(FileDataModel? file) {
    final style = TextStyle( fontSize: 20);
    return Container(
      margin: EdgeInsets.only(left: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Selected File Preview ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
          Text('Name: ${file?.name}',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22),),
          const SizedBox(height: 10,),
          Text('Type: ${file?.mime}',style: style),
          const SizedBox(height: 10,),
          Text('Size: ${file?.size}',style: style),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}