import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../data/dio.dart';
import '../models/user.dart';

class Auth extends ChangeNotifier {
  bool _authenticated = false;
  late User _user;
  // ignore: unnecessary_new
  final storage = new FlutterSecureStorage();

  bool get authenticated => _authenticated;
  User get user => _user;

  Future login({Map? Credentials}) async {
    // ignore: unused_local_variable
    String deviceId = await getDeviceId();

    try {
      Dio.Response response =
          await dio().post('/login', data: json.encode(Credentials));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.toString());
        print(data);
        if (data['error'] != null) {
          Fluttertoast.showToast(
              msg: "Nom d'utilisateur ou mot de pass incorrect",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP_RIGHT,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 102, 70, 177),
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (data['access_token'] != null) {
          String token = data['access_token'];
          await attempt(token);
          storeToken(token);
        }
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.response);
    }
  }

  Future attempt(String token) async {
    print("attempt auth");
    try {
      Dio.Response response = await dio().get('/user-profile',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

      _user = User.fromJson(json.decode(response.toString()));
      _authenticated = true;
    } catch (e) {
      _authenticated = false;
      log(e.toString());
    }

    notifyListeners();
  }

  Future getDeviceId() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } catch (e) {
      //
    }
    return deviceId;
  }

  storeToken(String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future getToken() async {
    return await storage.read(key: 'auth');
  }

  deleteToken() async {
    await storage.delete(key: 'auth');
  }

  void logout() {
    _authenticated = false;
    deleteToken();
    notifyListeners();
  }
}
