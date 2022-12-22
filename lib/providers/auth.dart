import 'dart:convert';
import 'dart:developer';

// ignore: library_prefixes
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../dio.dart';
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

    Dio.Response response =
        await dio().post('/login', data: json.encode(Credentials));

    String token = json.decode(response.toString())['access_token'];

    //print("deviceId => " + deviceId);

    await attempt(token);
    storeToken(token);
  }

  Future attempt(String token) async {
    try {
      Dio.Response response = await dio().get('/user-profile',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

      _user = User.fromJson(json.decode(response.toString()));
      _authenticated = true;

      log(_user.name!);
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
