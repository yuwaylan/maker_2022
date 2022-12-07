import 'dart:convert';

import 'package:led/vars.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class modeSelect extends StatefulWidget {
  const modeSelect({Key? key}) : super(key: key);

  @override
  _modeSelectState createState() => _modeSelectState();
}

class _modeSelectState extends State<modeSelect> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Color pickerColor = Color.fromARGB(255, 255, 0, 0);
  Color currentColor = Color.fromARGB(255, 255, 255, 0);

  void changeColor(Color color) {
    // setState(() => pickerColor = color);
    setState(() {
      pickerColor = color;
      var Colorstr = ColorToHex(pickerColor).toString();
      var pattern = "Color(0xff";
      mode_colors[5] =
          "#${Colorstr.substring(Colorstr.indexOf(pattern) + pattern.length, Colorstr.lastIndexOf(")"))}";

      print(mode_colors);
    });
  }

  Widget buttons(var index) {
    pickerColor = HexColor("${mode_colors[index]}");
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
            print('${mode_names[index]} Pressed!');
            if (index == 5) {
              print("自訂顏色！！");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actions: [
                        ElevatedButton(
                            child: const Text("OK"),
                            onPressed: () {
                              setState(() {});

                              Fluttertoast.showToast(
                                  msg: "自訂模式已設定為：${mode_colors[index]}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: HexColor(mode_colors[index]),
                                  textColor: HexColor(mode_colors[index])
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            }),
                        ElevatedButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: "您未做任何更動",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: HexColor(mode_colors[index]),
                                  textColor: HexColor(mode_colors[index])
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            }),
                      ],
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      content: SingleChildScrollView(
                        child: SlidePicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                          colorModel: ColorModel.rgb,
                          enableAlpha: false,
                          displayThumbColor: true,
                          showParams: true,
                          showIndicator: true,
                          indicatorBorderRadius: const BorderRadius.vertical(
                              top: Radius.circular(25)),
                        ),
                      ),
                    );
                  });

              var str = [mode_names, mode_colors];
              set_datas(mode: 1, str: jsonEncode(str));
            } else {
              Fluttertoast.showToast(
                  msg: "模式已更換為：${mode_colors[index]}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  backgroundColor: HexColor("${mode_colors[index]}"),
                  textColor: //************************************透過計算亮度進行文字顏色改變
                      HexColor("${mode_colors[index]}").computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                  fontSize: 16.0);
            }
            //---------------------------------------------------************************
            var str = [mode_names[index], mode_colors[index]];
            set_datas(mode: 0, str: jsonEncode(str));
            // send http request
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              width: 10,
              height: 10,
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
        title: Text("色彩模式選擇",
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
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return buttons(index);
                    // return Text("${index}");
                  }),
            )),
      ),
    );
  }
}
