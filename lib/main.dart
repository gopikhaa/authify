import 'package:flutter/material.dart';
import './pages/login.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Authify",
      theme: ThemeData(primarySwatch:Colors.blue ),
      home:AnimatedLoginPage() ,
    );
  }
}