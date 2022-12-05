import 'package:pushable_button/pushable_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class StateWidget extends StatefulWidget {
  const StateWidget({Key? key}) : super(key: key);

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final mode_names = ["模式一", "模式二", "模式三模式三", "模式四", "模式五", "模式四", "模式五"];
  final mode_colors = [
    "#FFFFFF",
    "#AAFF00",
    "#0000FF",
    "#545454",
    "#105205",
    "#545454",
    "#105205",
  ];
  var selected_index = 0;
  Color pickerColor = Color.fromARGB(255, 255, 0, 0);
  Color currentColor = Color.fromARGB(255, 255, 255, 0);

  void changeColor(Color color) {
    // setState(() => pickerColor = color);
    setState(() {
      pickerColor = color;
    });
  }

  Widget buttons(var index, var name, var color_hex) {
    TextEditingController _controller = TextEditingController();

    return Column(
      children: [
        PushableButton(
          height: 60,
          elevation: 2,
          hslColor: HSLColor.fromAHSL(0.7, 22, 0.50, 0.80),
          shadow: BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
          onPressed: () {},
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              width: 10,
              height: 10,
            ),
            Text(
              '桌次:${index + 1}, 模式:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              '${mode_names[index]}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: HexColor("${mode_colors[index]}"),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 0),
                  )
                ],
                color: HexColor("${mode_colors[index]}"),
                borderRadius: BorderRadius.all(
                  Radius.elliptical(10, 10),
                ),
              ),
              width: 5,
              height: 20,
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
        title: Text("目前狀態查看",
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
            padding: const EdgeInsets.only(left: 55, right: 55, top: 100),
            child: Center(
              child: ListView.builder(
                  itemCount: mode_names.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buttons(
                        index, mode_names[index], mode_colors[index]);
                  }),
            )),
      ),
    );
  }
}
