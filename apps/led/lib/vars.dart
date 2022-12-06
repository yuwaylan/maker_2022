// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import "dart:convert";

var host = "192.168.137.1:8000";
var mode_names;
var mode_colors;
// var mode_names = ["模式一", "模式二", "模式三", "模式四", "模式五", "自訂模式"];
// var mode_colors = [
//   "#FFFFFF",
//   "#AAFF00",
//   "#0000FF",
//   "#545454",
//   "#105205",
//   "#1111FF"
// ];

Future<void> get_datas() async {
  // get_status
  // set_status/<status>
  // get_modes
  // set_modes/<modes>
  final client = RetryClient(http.Client());
  var str;
  var decoded;

  // var arr = [mode_names, mode_colors];
  // print("GEN");
  // print(jsonEncode(arr));
  try {
    print("connect to ${host}");
    // print(await client.read(Uri.http(host, '/get_modes')));
    decoded = jsonDecode(await client.read(Uri.http(host, '/get_modes')));
    mode_names = decoded[0];
    mode_colors = decoded[1];
    print(mode_names);
    print(mode_colors);
  } finally {
    client.close();
  }
}

/// mode: set_status,set_modes
Future<void> set_datas({mode = 1, str = ""}) async {
  var api = ["/set_status/", "/set_modes/"];
  final client = RetryClient(http.Client());
  try {
    print(await client.read(Uri.http(host, api[mode] + str)));
  } finally {
    client.close();
  }
}
