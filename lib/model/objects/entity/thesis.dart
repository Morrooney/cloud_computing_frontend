import 'package:cloud_computing_frontend/model/objects/entity/student.dart';

import 'docent.dart';

class Thesis{

  int id;
  String title;
  String type;
  Student thesisStudent;
  Docent mainSupervisor;

  Thesis({required this.id,required this.title, required this.type, required this.thesisStudent, required this.mainSupervisor});

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      thesisStudent: Student.fromJson(json["thesisStudent"]),
      mainSupervisor: Docent.fromJson(json["mainSupervisor"])
    );
  }

  //costruisci oggetto json to dart
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'type': type,
    'thesisStudent': thesisStudent.toJson(),
    'mainSupervisor': mainSupervisor.toJson(),
  };
}