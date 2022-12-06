// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, avoid_print, sort_child_properties_last

import 'dart:math';

import 'package:pushable_button/pushable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blob/blob_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
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
  bool _hasSpeech = false;
  bool _logEvents = false;
  bool _onDevice = false;
  final TextEditingController _pauseForController =
      TextEditingController(text: '3');
  final TextEditingController _listenForController =
      TextEditingController(text: '10');
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  bool hasSpeech = false;
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

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

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse(_pauseForController.text);
    final listenFor = int.tryParse(_listenForController.text);
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      partialResults: true,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
      onDevice: _onDevice,
    );
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  /// *****************************************************************************
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      // lastWords = '${result.recognizedWords} - ${result.finalResult}';
      lastWords = '${result.recognizedWords}';
      show_strings = lastWords;
    });
  }

  /// *****************************************************************************

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }

  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
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
                      startListening();
                    });
                    print("presssss");
                  },
                  onPointerUp: (details) {
                    setState(() {
                      show_strings = (show_strings == ""
                          ? "${hint_strings[Random().nextInt(hint_strings.length)]}"
                          : show_strings);
                      stopListening();
                      is_Pressed = false;
                    });
                    print("Cancel");
                  }),
            ),
            Container(
              width: 50,
              height: 120,
            )
          ],
        ),
      ),
    );
  }
}
