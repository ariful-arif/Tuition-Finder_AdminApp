import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuition_admin_app/pages/book_list.dart';
import 'package:tuition_admin_app/pages/log_in.dart';
import 'package:tuition_admin_app/pages/pdf.dart';
import 'package:tuition_admin_app/pages/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard",style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return LogIn();
                }),
              );
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TeacherScroll(
                        )));
              },
              style: ElevatedButton.styleFrom(
                elevation: 10,
                  primary: Colors.blueGrey,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              child: const Text('Users',style: TextStyle(fontSize: 20),),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BookListPage(
                        )));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              child: const Text('Books',style: TextStyle(fontSize: 20),),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              child: const Text('Student post',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              child: const Text('Teacher post',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              child: const Text('Cheating History',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            ),

          ],
        ),
      ),
    );
  }
}
