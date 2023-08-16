import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  setData(data) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15.0, bottom: 40, left: 15, right: 15),
        child: Column(
          children: [
            Container(
              //margin: EdgeInsets.all(15),
              alignment: Alignment.center,
              //height: 200,
              color: Colors.black12,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: CircleAvatar(
                      radius: 75,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Image.network(data['profilepic'],))
                    ),
                  ),
                  Text(
                    data['fullname'],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data['email'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      //mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.man,
                                  color: Colors.grey,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Gender : ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              data['gender'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.date_range_sharp,
                                  color: Colors.grey,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Age : ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              data['age'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Date of birth : ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text(
                            data['dob'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Phone : ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              data['phone'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 210),
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (_) => EditProfile(
                        //                     userModel: widget.userModel,
                        //                     firebaseUser: widget.firebaseUser,
                        //                   )));
                        //     },
                        //     child: Text("Edit Profile"),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;

              if (data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return setData(data);
            }),
      )),
    );
  }
}
