
import 'package:firebase3/categorise/add.dart';
import 'package:firebase3/widget/home_page.dart';
import 'package:firebase3/widget/image_paker.dart';
import 'package:firebase3/widget/login.dart';
import 'package:firebase3/widget/sign_up.dart';
import 'package:firebase3/widget/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async{

   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  


  @override
  void initState() {

    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('========User is currently signed out!');
    } else {
      print('========User is signed in!');
    }
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme:AppBarTheme(
          backgroundColor: Colors.grey[50],
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(
            color: Colors.black
          )
        ) ),
      debugShowCheckedModeBanner: false,
       home:Test(),
      // (FirebaseAuth.instance.currentUser != null &&
      //  FirebaseAuth.instance.currentUser!.emailVerified)? HomePage(): Login(),
      routes: {
        'SignUp':(context) => SignUp(),
        'Login' :(context) => Login(),
        'HomePage' :(context) => HomePage(),
        'AddCategory' :(context) => AddCategory()
      },
    );
  }
}
     