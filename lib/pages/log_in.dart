import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tuition_admin_app/pages/home_page.dart';


class LogIn extends StatefulWidget {


  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
bool obscureText =true;

  void login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (email == "" || password == "") {
      Fluttertoast.showToast(msg: "Please fill all the details");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          // Check if the logged-in user is an admin
          bool isAdmin = await checkAdminRole(userCredential.user!);

          if (isAdmin) {
            // If the user is an admin, navigate to the admin homepage
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
          } else {
            // If the user is not an admin, show a message or take appropriate action
            Fluttertoast.showToast(msg: "You are not an admin!");
          }
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  Future<bool> checkAdminRole(User user) async {
    try {
      // Get the reference to the Firestore collection "Admins"
      CollectionReference adminsCollection =
      FirebaseFirestore.instance.collection("Admins");

      // Query the "Admins" collection to check if the user's email is present
      // This query will return a QuerySnapshot containing all the documents
      // where the "email" field matches the user's email
      QuerySnapshot querySnapshot = await adminsCollection
          .where("email", isEqualTo: user.email)
          .limit(1)
          .get();

      // If the query returns at least one document, it means the user is an admin
      // Otherwise, the user is not an admin
      return querySnapshot.size > 0;
    } catch (e) {
      log("Error checking admin role: $e");
      return false; // Return false in case of any error
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Admin Login..',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                         // color: Colors.black26
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      onSaved: (value) {},
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      //keyboardType: TextInputType.emailAddress,
                      controller: _passwordController,
                      obscureText: obscureText,
                      obscuringCharacter: ".",
                      onSaved: (value) {},
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                            child:obscureText?
                            Icon(Icons.visibility)
                                :Icon(Icons.visibility_off),),
                        hintText: 'Password',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        login();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.purple,
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(5, 5)),
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(3, 3)),
                            ]),
                        child: const Text(
                          "LogIn",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         primary: Colors.cyan,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)
              //       ),
              //       textStyle: TextStyle(color: Colors.black,
              //           fontWeight: FontWeight.bold)
              //     ),
              //     onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (_)=>ForgotPassword()));
              //
              // },
              //     child: Text("Forgot Password")),
              const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text("Don't have an account?"),
              //     TextButton(
              //         onPressed: () {
              //           Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
              //         },
              //         child: const Text("SignUp")),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // void login() async {
  //   String email = _emailController.text.trim();
  //   String password = _passwordController.text.trim();
  //   if (email == "" || password == "") {
  //     Fluttertoast.showToast(msg: "Please fill all the details");
  //   } else {
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email, password: password);
  //       if (userCredential.user != null) {
  //         //Navigator.popUntil(context, (route) => route.isFirst);
  //         //Navigator.pushNamed(context, HomePage.routeName);
  //             Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
  //       }
  //     } on FirebaseAuthException catch (ex) {
  //       log(ex.code.toString());
  //     }
  //   }
  // }
}
