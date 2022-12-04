import 'package:pushable_button/pushable_button.dart';
import 'package:flutter/material.dart';

class modeSelect extends StatefulWidget {
  const modeSelect({Key? key}) : super(key: key);

  @override
  _modeSelectState createState() => _modeSelectState();
}

class _modeSelectState extends State<modeSelect> {
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
                        const EdgeInsets.only(top: 170, left: 20, right: 20),
                    child: Image.asset('assets/images/cover_table_logo.png'),
                  ),
                  const SizedBox(
                    height: 100,
                    width: 20,
                  ),
                  PushableButton(
                    child: const Text(
                      '模式選擇',
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
                      print('模式選擇 Pressed!');
                    },
                  ),
                  SizedBox(
                    height: 40,
                    width: 20,
                  ),
                  PushableButton(
                    child: Text('語音控制',
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
                    onPressed: () => print('語音控制 Pressed!'),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
