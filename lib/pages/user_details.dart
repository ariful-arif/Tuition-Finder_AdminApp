import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TeacherDetailsPage extends StatefulWidget {
  static const String routeName = '/teacherDetails';
  var _teacher1;
  TeacherDetailsPage(this._teacher1,);

  @override
  State<TeacherDetailsPage> createState() => _TeacherDetailsPageState();
}

class _TeacherDetailsPageState extends State<TeacherDetailsPage> {

  // Future addToFavourite() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   var currentUser = _auth.currentUser;
  //   CollectionReference _collectionRef =
  //   FirebaseFirestore.instance.collection("users_favourite");
  //   return _collectionRef
  //       .doc(currentUser!.email)
  //       .collection("items")
  //       .doc()
  //       .set({
  //     "name": widget._teacher1["teacher-name"],
  //     "email": widget._teacher1["teacher-email"],
  //     "images": widget._teacher1["proimg"],
  //   }).then((value) => Fluttertoast.showToast(msg: "Added to favourite"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details",style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.only(top:15.0,bottom: 40,left: 15,right: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)
                    )
                ),
                //margin: EdgeInsets.all(15),
                alignment: Alignment.center,
                //height: 200,
                //color: Colors.black12,
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: CircleAvatar(
                        radius: 70,

                        child: CircleAvatar(
                          radius: 65,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child: Image.network(widget._teacher1['proimg'])) ,
                        ),
                      ),
                    ),
                    Text(
                      widget._teacher1['fullname'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget._teacher1['email'],
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // StreamBuilder(
                    //   stream: FirebaseFirestore.instance.collection("users_favourite").doc(FirebaseAuth.instance.currentUser!.email)
                    //       .collection("items").where("email",isEqualTo: widget._teacher1['teacher-email']).snapshots(),
                    //   builder: (BuildContext context, AsyncSnapshot snapshot){
                    //     if(snapshot.data==null){
                    //       return Text("");
                    //     }
                    //     return Padding(
                    //       padding: const EdgeInsets.only(right: 8),
                    //       child: CircleAvatar(
                    //         backgroundColor: Colors.lightBlue,
                    //         child: IconButton(
                    //           onPressed: () => snapshot.data.docs.length==0?addToFavourite()
                    //               :Fluttertoast.showToast(msg: "Already Added") ,
                    //           icon: snapshot.data.docs.length==0? Icon(
                    //             Icons.favorite_outline,
                    //             color: Colors.white,
                    //           ):Icon(
                    //             Icons.favorite,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    //mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Department : ",
                      //   style: TextStyle(
                      //       fontSize: 30,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black54),
                      // ),
                      // Text(widget._teacher1['teacher-department'],
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black54),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "Institute : ",
                      //   style: TextStyle(
                      //       fontSize: 30,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black54),
                      // ),
                      // Text(widget._teacher1['teacher-institute'],
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black54),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.man,
                                color: Colors.blueGrey,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Gender : ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Text(
                            widget._teacher1['gender'],
                            style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
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
                            radius: 15,
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.date_range_sharp,
                                color: Colors.blueGrey,size: 18,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Age : ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Text(
                            widget._teacher1['age'],
                            style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
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
                            radius: 15,
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.date_range,
                                color: Colors.blueGrey,size: 18,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Date of birth : ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          widget._teacher1['dob'],
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.phone,
                                color: Colors.blueGrey,size: 18,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Phone : ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Text(
                            widget._teacher1['phone'],
                            style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
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
                            radius: 15,
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.password,
                                color: Colors.blueGrey,size: 18,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Password : ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Text(
                            widget._teacher1['pass'],
                            style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
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
                            radius: 15,
                              backgroundColor: Colors.black12,
                              child: Icon(
                                Icons.wrong_location_outlined,
                                color: Colors.blueGrey,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "uid : ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          widget._teacher1['uid'],
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
