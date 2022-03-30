import 'package:flutter/material.dart';
import 'package:taredas_api/views/home_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'TarefasApi',
      theme: ThemeData(
        primarySwatch: Colors.green ,
        primaryColor: const Color(0xff1CB273),
      ),
      debugShowCheckedModeBanner: false,
      home:  const HomePage(),
    );
  }
}