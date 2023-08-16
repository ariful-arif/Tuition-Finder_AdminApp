import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tuition_admin_app/pages/user_details.dart';

class TeacherScroll extends StatefulWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  State<TeacherScroll> createState() => _TeacherScrollState();
}

class _TeacherScrollState extends State<TeacherScroll> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List _teacher = [];
  var fireStoreInstance = FirebaseFirestore.instance;
  fetchData() async {
    QuerySnapshot qn = await fireStoreInstance.collection("users").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _teacher.add({
          "fullname": qn.docs[i]["fullname"],
          "pass": qn.docs[i]["password"],
          "email": qn.docs[i]["email"],
          "phone": qn.docs[i]["phone"],
          "gender": qn.docs[i]["gender"],
          "dob": qn.docs[i]["dob"],
          "age": qn.docs[i]["age"],
          "proimg": qn.docs[i]['profilepic'],
          "uid": qn.docs[i]['uid'],
        });
      }
    });
  }

  @override
  void initState() {
    fetchData();
    //fetchImage();
    super.initState();
  }

  void deleteUserFromList(String userId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .delete()
        .then((_) {
      // If the deletion is successful, update the UI by removing the user from the _teacher list.
      setState(() {
        _teacher.removeWhere((user) => user["uid"] == userId);
      });
      print("User deleted from the list successfully");
    }).catchError((error) {
      print("Error deleting user from the list: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "User's List",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
          ),
          //backgroundColor: Colors.transparent,
          // elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            // gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,childAspectRatio: .65,) ,
            physics: BouncingScrollPhysics(),
            // scrollDirection: Axis.vertical,
            itemCount: _teacher.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                TeacherDetailsPage(_teacher[index])));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 20,
                    color: Colors.white54,
                    child:
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     children: [
                        //       CircleAvatar(
                        //         radius: 50,
                        //         child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: Image.network(_teacher[index]['proimg'])
                        //         ),
                        //       ),
                        //       Container(
                        //         height: 50,
                        //         child: Text(_teacher[index]["fullname"],
                        //             style: TextStyle(fontSize: 20,color: Colors.blue,
                        //                 fontWeight:FontWeight.bold )),
                        //       ),
                        //       Container(
                        //         height: 50,
                        //         child: Text(_teacher[index]["email"],
                        //             style: TextStyle(fontSize: 18)),
                        //       ),
                        //       Container(
                        //         height: 25,
                        //         child: Text(_teacher[index]["phone"],
                        //             style: TextStyle(fontSize: 18)),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:
                                      Image.network(_teacher[index]['proimg'])),
                            ),
                            title: Text(
                              _teacher[index]["fullname"],
                              // style: TextStyle(fontSize: 25)
                            ),
                            subtitle: Text(
                              _teacher[index]["email"],
                              // style: TextStyle(fontSize: 18)
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.topSlide,
                                      showCloseIcon: true,
                                      title: "Warning",
                                      desc: "Do you want to delete this user?",
                                      btnCancelOnPress: (){},
                                      btnOkText: "Yes",
                                      btnCancelText: "No",
                                      btnOkOnPress: () {
                                        String userIdToDelete =
                                            _teacher[index]['uid'];
                                        deleteUserFromList(userIdToDelete);
                                      }).show();
                                },
                                icon: Icon(Icons.delete))
                            // IconButton(
                            //     onPressed: () async {
                            //       showDialog(
                            //           context: context,
                            //           builder: (context) {
                            //             return AlertDialog(
                            //               // backgroundColor: Colors.,
                            //               title: Text("Fill all Field"),
                            //               content: Column(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 children: [
                            //                   TextFormField(
                            //                     controller: emailController,
                            //                     decoration: InputDecoration(
                            //                         prefixIcon: Icon(Icons.email),
                            //                         border: OutlineInputBorder()),
                            //                   ),
                            //                   SizedBox(
                            //                     height: 5,
                            //                   ),
                            //                   TextFormField(
                            //                     controller: passwordController,
                            //                     decoration: InputDecoration(
                            //                         prefixIcon: Icon(Icons.password),
                            //                         border: OutlineInputBorder()),
                            //                   ),
                            //                   SizedBox(
                            //                     height: 5,
                            //                   ),
                            //                   ElevatedButton(
                            //                       onPressed: () {
                            //                         deleteAccount(
                            //                             emailController.text,
                            //                             passwordController.text);
                            //                       },
                            //                       child: Text("Delete"))
                            //                 ],
                            //               ),
                            //             );
                            //           });
                            //     },
                            //     icon: Icon(Icons.delete)),
                            ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  // void deleteAccount(String email, String pass) async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   AuthCredential credential = EmailAuthProvider.credential(email: email, password: pass);
  //
  //   // Reauthenticate the user with the provided credentials
  //   await user
  //       ?.reauthenticateWithCredential(credential)
  //       .then((value) {
  //     // If reauthentication is successful, delete the user account
  //     value.user?.delete().then((res) {
  //       print("User account deleted successfully");
  //     }).catchError((onError) {
  //       print("Error occurred while deleting user account: $onError");
  //     });
  //   })
  //       .catchError((onError) {
  //     print("Error occurred while reauthenticating user: $onError");
  //   });
  // }

// void deleteAccount(String email, String pass) async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   AuthCredential credential =
  //       EmailAuthProvider.credential(email: email, password: pass);
  //   await user
  //       ?.reauthenticateWithCredential(credential)
  //       .then((value) => value.user
  //           ?.delete()
  //           .then((res) => print("Success")))
  //       .catchError((onError) => print("error"));
  // }
}
