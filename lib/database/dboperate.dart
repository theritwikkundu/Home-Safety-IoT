import 'package:firebase_database/firebase_database.dart';

class DBOperate{
  /*function to write registration data*/
  static void writeRegData(String name, String dob, String phone, String password){
    // database reference string
    final DBRef = FirebaseDatabase.instance.reference();
    DBRef.child("regn").child(phone).set({
      'phone': phone,
      'name': name,
      'dob': dob,
      'pass': password
    });
    print("data created");
  }
}