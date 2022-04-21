import 'package:flutter/material.dart';
import 'package:clinical_scoring/child.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Child-Pugh评分',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: ChildPughPage(),
    );
  }
}
