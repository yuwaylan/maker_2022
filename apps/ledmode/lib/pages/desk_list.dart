import 'package:ledmode/pages/modeSet.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DeskSelect extends StatefulWidget {
  const DeskSelect({Key? key}) : super(key: key);

  @override
  _DeskSelectState createState() => _DeskSelectState();
}

class _DeskSelectState extends State<DeskSelect> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget buttons(var index) {
    TextEditingController _controller = TextEditingController();

    return Column(
      children: [
        PushableButton(
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => modeSelect(index)));
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              width: 10,
              height: 10,
            ),
            Text(
              '桌次：${index + 1}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
          ]),
        ),
        SizedBox(
          //for 高度spacing
          height: 20,
          width: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("桌次選擇",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 255, 255, 255),
              // color: Color.fromARGB(255, 115, 43, 26),
            )),
        shadowColor: Color.fromARGB(0, 217, 180, 161),
        backgroundColor: Color.fromARGB(255, 142, 110, 87),
      ),
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
            padding: const EdgeInsets.only(left: 55, right: 55, top: 120),
            child: Center(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return buttons(index);
                  }),
            )),
      ),
    );
  }
}
