// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, avoid_print, sort_child_properties_last

import 'dart:math';

import 'package:pushable_button/pushable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blob/blob_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'modeSelect.dart';

class voiceCtrlWidget extends StatefulWidget {
  const voiceCtrlWidget({Key? key}) : super(key: key);

  @override
  _voiceCtrlState createState() => _voiceCtrlState();
}

class _voiceCtrlState extends State<voiceCtrlWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final blobLayoutSize = const Size(150, 140);
  bool has_speaked = false;
  var hint_strings = [
    "你可以試著說說看:\n\t設定為舒眠情境\n\t現在心情很好",
    "試試看:\n\t設定為「模式一」\n\t緊急呼叫"
  ];
  var show_strings = "你可以試著說說看:\n\t設定為舒眠情境\n\t現在心情很好";
  bool is_Pressed = false;

  Widget Btn_Mic() {
    return Column(children: [
      RawMaterialButton(
        onPressed: () {
          setState(() {
            is_Pressed = true;
          });
          print("start voice ctrl");
        },
        elevation: 2.0,
        fillColor: Color.fromARGB(255, 242, 103, 22),
        child: Icon(
          Icons.keyboard_voice,
          size: 40.0,
        ),
        padding: EdgeInsets.all(50.0),
        shape: CircleBorder(),
      ),
    ]);
  }

  Widget On_Mic_pressed() {
    return SizedBox(
      width: blobLayoutSize.width,
      height: blobLayoutSize.height,
      child: BlobLayout.from(
        blobs: [
          RotatingParticle.random(blobLayoutSize),
          RotatingParticle.random(blobLayoutSize),
          RotatingParticle.random(blobLayoutSize),
          RotatingParticle.random(blobLayoutSize),
          RotatingParticle.random(blobLayoutSize),
          RotatingParticle.random(blobLayoutSize),
          RotatingParticle.random(blobLayoutSize),
          RotatingParticle.random(blobLayoutSize),
        ],
        blobsColor: Color.fromARGB(255, 242, 103, 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("語音控制模式",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        shadowColor: Color.fromARGB(0, 217, 180, 161),
        backgroundColor: Color.fromARGB(255, 142, 110, 87),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.srgbToLinearGamma(),
            image: AssetImage(
              "assets/images/Background.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 400,
              child: Text(
                "${show_strings}",
                style: TextStyle(
                  fontSize: 20,
                  height: 2,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            Container(
              child: Listener(
                  child: is_Pressed ? On_Mic_pressed() : Btn_Mic(),
                  onPointerDown: (details) {
                    setState(() {
                      show_strings = "";
                      is_Pressed = true;
                    });
                    print("presssss");
                  },
                  onPointerUp: (details) {
                    setState(() {
                      show_strings = (show_strings == ""
                          ? "${hint_strings[Random().nextInt(hint_strings.length)]}"
                          : show_strings);
                      is_Pressed = false;
                    });
                    print("Cancel");
                  }),
            ),
            Container(
              width: 50,
              height: 120,
              // color: Colors.pink,
            )
          ],
        ),
      ),
    );
  }
}
