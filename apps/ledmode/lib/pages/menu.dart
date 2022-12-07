import 'package:ledmode/pages/desk_list.dart';
import 'package:ledmode/pages/state_list.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:flutter/material.dart';

import 'modeSet.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.srgbToLinearGamma(),
            image: AssetImage(
              "assets/images/Background.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 190, left: 20, right: 20),
                    child: Image.asset(
                      'assets/images/cover_table_logo.png',
                      opacity: const AlwaysStoppedAnimation(.9),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                    width: 20,
                  ),
                  PushableButton(
                    child: const Text(
                      '模式設定',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w900,
                        // color: Color.fromARGB(255, 115, 43, 26),
                      ),
                    ),
                    height: 60,
                    elevation: 8,
                    hslColor: HSLColor.fromAHSL(0.7, 22, 0.50, 0.80),
                    shadow: BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                    onPressed: () {
                      print('模式設定 Pressed!');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeskSelect()));
                    },
                  ),
                  SizedBox(
                    height: 40,
                    width: 20,
                  ),
                  PushableButton(
                    child: Text('目前狀態查看',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 255, 255, 255),
                          // color: Color.fromARGB(255, 115, 43, 26),
                        )),
                    height: 60,
                    elevation: 8,
                    hslColor: HSLColor.fromAHSL(0.7, 22, 0.50, 0.80),
                    shadow: BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StateWidget()));
                      print('目前狀態查看 Pressed!');
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
