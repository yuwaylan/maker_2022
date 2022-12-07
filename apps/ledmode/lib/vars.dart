// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import "dart:convert";

var host = "192.168.137.1:8000";
var mode_names;
var mode_colors;
var mode_content;

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

Future<void> F_get_datas() async {
  print("FFFF");
}

Future<void> get_status() async {
  // get_status =>目前模式
  // set_status/<status> =>設定模式
  // get_modes =>取得模式設定
  // set_modes/<modes>  => 設定模式設定
  final client = RetryClient(http.Client());
  var mode_name;
  var mode_color;

  var decoded;
  try {
    print("connect to ${host}");
    print(await client.read(Uri.http(host, '/get_status')));
    decoded = jsonDecode(await client.read(Uri.http(host, '/get_status')));
    mode_name = decoded[0];
    mode_color = decoded[1];
    print(mode_name);
    print(mode_color);
  } finally {
    client.close();
  }
  mode_content = [mode_name, mode_color];
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
