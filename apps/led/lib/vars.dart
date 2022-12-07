// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import "dart:convert";

var host = "192.168.137.1:8000";
var mode_names;
var mode_colors;

Future<void> get_datas() async {
  // get_status =>目前模式
  // set_status/<status> =>設定模式
  // get_modes =>取得模式設定
  // set_modes/<modes>  => 設定模式設定
  final client = RetryClient(http.Client());
  var str;
  var decoded;
  try {
    print("connect to ${host}");
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
Future<void> set_datas({mode = 0, str = ""}) async {
  var api = ["/set_status/", "/set_modes/"];
  final client = RetryClient(http.Client());
  try {
    print(await client.read(Uri.http(host, api[mode] + str)));
  } finally {
    client.close();
  }
}
