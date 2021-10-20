import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:homesafety_app/database/dboperate.dart';

class RegisterP extends StatelessWidget {
  TextEditingController nm = TextEditingController();
  TextEditingController db = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController pw = TextEditingController();

  //flag is true when no matching phone number in database
  bool flag=true;
  Future<void> credValid(String phn) async
  {
    // database reference variable
    final DBRef = await FirebaseDatabase.instance.reference();
    await DBRef.child("regn").once().then((DataSnapshot dataSnapShot){
      var newdata = dataSnapShot.value;
      newdata.forEach((key, values) {
        // print(values['phone']);
        if ((values['phone']) == phn) {
          ph.clear();
          nm.clear();
          db.clear();
          pw.clear();
          flag = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey[700],
          ),
          elevation: 24,
          title: Text(
            "Home Safety",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Wind',
              color: Colors.grey[700],
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffFAF3DD),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffffc226),
                Color(0xffffc226),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'Nexa',
                    color: Color(0xffFAF3DD),
                  ),
                ),
                SizedBox(height: 50,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nm,
                      // maxLength: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xffFAF3DD),
                        filled: true,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Nexa',
                          color: Colors.black54,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Righteous',
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: db,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xffFAF3DD),
                        filled: true,
                        hintText: 'DOB',
                        hintStyle: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Nexa',
                          color: Colors.black54,
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Righteous',
                        color: Colors.black87,
                      ),
                    ),
                    TextField(
                      controller: ph,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xffFAF3DD),
                        filled: true,
                        hintText: 'Phone',
                        hintStyle: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Nexa',
                          color: Colors.black54,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Righteous',
                        color: Colors.black87,
                      ),
                    ),
                    // SizedBox(height: 20,),
                    TextField(
                      controller: pw,
                      maxLength: 20,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xffFAF3DD),
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Nexa',
                          color: Colors.black54,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Righteous',
                        color: Colors.black87,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () async{
                        if(ph.text.length==10 && pw.text.length >= 4 && db.text.length!=0 && nm.text.length!=0){
                          await credValid(ph.text);
                        }
                        else{
                          flag = false;
                        }

                        // print("Received flag = "+flag.toString()+" in line 199");

                        if(flag) {
                          // print("Inside of if");
                          DBOperate.writeRegData(nm.text,db.text,ph.text,pw.text);
                          Navigator.pop(context);
                          return showDialog(context: context, barrierDismissible: false, builder: (context){
                            return AlertDialog(
                              title: Text(
                                "Application submitted!",
                                textAlign: TextAlign.center,
                              ),
                              titleTextStyle: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Nexa',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              content: Icon(
                                Icons.done_outline_outlined,
                                size: 72,
                                color: Colors.black87,
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Close',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Nexa',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  splashColor: Colors.black87,
                                )
                              ],
                              backgroundColor: Color(0xffFAF3DD),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            );
                          }
                          );
                        }
                        else {
                          flag=true;
                          return showDialog(context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Try again!",
                                    textAlign: TextAlign.center,
                                  ),
                                  titleTextStyle: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'Nexa',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  content: Icon(
                                    Icons.warning_amber_outlined,
                                    size: 72,
                                    color: Colors.black87,
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Close',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'Nexa',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      splashColor: Colors.black87,
                                    )
                                  ],
                                  backgroundColor: Color(0xffFAF3DD),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                );
                              }
                          );
                        }
                      },
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Nexa',
                          color: Colors.black87,
                        ),
                      ),
                      elevation: 24,
                      padding: EdgeInsets.fromLTRB(45, 14, 45, 13),
                      color: Color(0xffFAF3DD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                  ],
                ),
                // SizedBox(height: 0,),
              ],
            ),
          ),
        ),
        /*database handler*/
        // floatingActionButton: Container(
        //   width: 70,
        //   height: 70,
        //   alignment: Alignment.topLeft,
        //   child: FloatingActionButton(
        //     elevation: 100,
        //     onPressed: (){
        //       // deleteData();
        //       // writeData();
        //       // readData();
        //     },
        //     backgroundColor: Color(0x004A7C59),
        //     // splashColor: Color(0x004A7C59),
        //     // shape: ,
        //     child: Icon(
        //       Icons.info_sharp,
        //       size: 60,
        //       color: Colors.black87,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  /*database handler*/
  // final DBRef = FirebaseDatabase.instance.reference();
  // void writeData(){
  //   DBRef.child("regn").child("9674").set({
  //     'phone': "9674",
  //     'name': "Ritwik",
  //     'dob': "06/10",
  //     'pass': "1234",
  //   });
  //   print("Data created");
  // }

}