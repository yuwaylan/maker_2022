import 'dart:convert';

import 'package:ledmode/vars.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class modeSelect extends StatefulWidget {
  final id;
  const modeSelect(this.id);

  @override
  _modeSelectState createState() => _modeSelectState(id);
}

class _modeSelectState extends State<modeSelect> {
  final id;
  _modeSelectState(this.id);

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
          elevation: 8,
          hslColor: HSLColor.fromAHSL(0.7, 22, 0.50, 0.80),
          shadow: BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
          onPressed: () {
            pickerColor = HexColor(color_hex);
            selected_index = index;
            _controller.text = name;
            print('${name} Pressed!');
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color.fromARGB(255, 230, 230, 230),
                    actions: [
                      ElevatedButton(
                          child: const Text("OK"),
                          onPressed: () {
                            setState(() {
                              var Colorstr = ColorToHex(pickerColor).toString();
                              var pattern = "Color(0xff";
                              mode_colors[selected_index] =
                                  "#${Colorstr.substring(Colorstr.indexOf(pattern) + pattern.length, Colorstr.lastIndexOf(")"))}";
                              mode_names[selected_index] = _controller.text;

                              print(mode_colors);
                              print(mode_names);
                            });

                            Fluttertoast.showToast(
                                msg:
                                    "模式「${mode_names[selected_index]}」已設定為：${mode_colors[selected_index]}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    HexColor(mode_colors[selected_index]),
                                textColor: HexColor(mode_colors[selected_index])
                                            .computeLuminance() >
                                        0.5
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 16.0);
                            var str = [mode_names, mode_colors];
                            set_datas(mode: 1, str: jsonEncode(str));
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
                                backgroundColor:
                                    HexColor(mode_colors[selected_index]),
                                textColor: HexColor(mode_colors[selected_index])
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
                      child: Column(children: [
                        SlidePicker(
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
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            maxLength: 6,
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: "模式名稱",
                              prefixIcon: Icon(Icons.style),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 10,
                        )
                      ]),
                    ),
                  );
                });

            //---------------------------------------------------************************
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
        title: Text("桌次${id + 1}色彩模式設定",
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
<<<<<<< HEAD
          child: Padding(
            padding: const EdgeInsets.only(left: 55, right: 55, top: 120),
            child: FutureBuilder(
              future: get_datas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return buttons(
                              index, mode_names[index], mode_colors[index]);
                        }),
                  );
                } else {
                  return Container(
                    child: Text(
                      "資料載入中....",
                      style: TextStyle(
                        fontSize: 20,
                        height: 2,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  );
                }
              },
            ),
          )),
=======
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 55, right: 55, top: 120),
            child: Center(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return buttons(
                        index, mode_names[index], mode_colors[index]);
                  }),
            )),
      ),
>>>>>>> parent of 3969ac1 (finish led mode)
    );
  }
}
