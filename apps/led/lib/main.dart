// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:led/pages/menu.dart';
import 'package:led/vars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get_datas(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: SplashPage(),
          );
        } else {
          return MaterialApp(
            home: MenuWidget(),
          );
        }
      },
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x000000),
      body: Center(
        child: Image.asset('assets/images/orig_cover_table_logo.png'),
      ),
    );
  }
}
