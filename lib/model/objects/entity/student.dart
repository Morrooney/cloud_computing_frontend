import 'package:cloud_computing_frontend/model/objects/entity/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student extends Person{

  String degreeCourse;
  String registrationNumber;

  Student({required int id, required String name, required String surname, required String department, required String email,required String degreeCourse,required String registrationNumber}):
        this.degreeCourse = degreeCourse,
        this.registrationNumber = registrationNumber,
        super(id: id, name: name, surname: surname, department: department, email: email);

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      department: json['department'],
      email: json['email'],
      degreeCourse: json['degreeCourse'],
      registrationNumber: json['registrationNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'surname': surname,
    'department': department,
    'email': email,
    'degreeCourse': degreeCourse,
    'registrationNumber': registrationNumber,
  };

  //creo l'utente che è acceduto
  void setUserPrefs() async{
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setInt("id", id);
    userData.setString("email", email);
    userData.setString("name", name);
    userData.setString("surname", surname);
    userData.setString("department", department);
    userData.setString("degreeCourse", degreeCourse);
    userData.setString("registrationNumber", registrationNumber);
  }


}