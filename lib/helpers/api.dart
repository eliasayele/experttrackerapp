import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio(); //this doesn't work because of the methods are static

  //login method with email and password it deployed
  static login(email, password) async {
    try {
      return await Dio().post('https://expertracker.herokuapp.com/api/auth',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.jsonContentType));
    } on DioError catch (e) {
      print('this is begin');
      print(e.message);
      print('this is end');
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  static signup(name, email, password, phonenumber, latitude, longitude) async {
    try {
      Response response =
          await Dio().post('https://expertracker.herokuapp.com/api/users',
              data: {
                "name": name,
                "email": email,
                "password": password,
                "phonenumber": phonenumber,
                "latitude": latitude,
                "longitude": longitude,
                "type": "customer"
              },
              options: Options(contentType: Headers.jsonContentType));
      return response;
    } on DioError catch (e) {
      print('this is begin');
      print(e.message);
      print('this is end');
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  static createprofile(
      token,
      profession,
      company,
      skills,
      city,
      address,
      bio,
      website,
      facebook,
      twitter,
      youtube,
      instagram,
      linkedin,
      githubusername) async {
    try {
      Options options = new Options(headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      });
      Response response =
          await Dio().post('https://expertracker.herokuapp.com/api/profile',
              data: {
                "profession": profession,
                "company": company,
                "skills": skills,
                "city": city,
                "address": address,
                "bio": bio,
                "website": website,
                "facebook": facebook,
                "twitter": twitter,
                "youtube": youtube,
                "instagram": instagram,
                "linkedin": linkedin,
                "githubusername": githubusername,
              },
              options: options);
      return response;
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  //get info as expected token is required
  static getinfo(token) async {
    try {
      Options options = new Options(headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      });

      Response response = await Dio().get(
        'https://expertracker.herokuapp.com/api/auth',
        options: options,
      );
      // var decodedData = jsonDecode(response.data);
      return response;
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  static searchresult(token, profession) async {
    print(profession);

    try {
      Options option = new Options(headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      });

      Response response = await Dio().get(
        'https://expertracker.herokuapp.com/api/profile/searchprofession/$profession',
        options: option,
      );
      return response.data;
    } catch (e) {
      //on DioError
      print(e);
    }
    return;
  }

  //get all users profile for showing markers pourpose
  static getAllProfiles(token) async {
    try {
      Options options = new Options(headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      });

      Response response = await Dio().get(
        'https://expertracker.herokuapp.com/api/profile/',
        options: options,
      );
      // var decodedData = jsonDecode(response.data);

      return response.data;
    } on DioError catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  //get profile  By id
  static getProfileById(token) async {
    try {
      Options options = new Options(headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      });

      Response response = await Dio().get(
        'https://expertracker.herokuapp.com/api/profile/me',
        options: options,
      );
      // var decodedData = jsonDecode(response.data);

      return response.data;
    } on DioError catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  static makeOnline(token) async {
    try {
      Options options = new Options(headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      });

      Response response = await Dio().post(
          'https://expertracker.herokuapp.com/api/profile/online',
          options: options);
      return response;
    } on DioError catch (e) {
      print('this is begin');
      print(e.message);
      print('this is end');
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  static makeOffline(token) async {
    try {
      Options options = new Options(headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      });
      Response response = await Dio().post(
          'https://expertracker.herokuapp.com/api/profile/offline',
          options: options);
      return response;
    } on DioError catch (e) {
      print('this is begin');
      print(e.message);
      print('this is end');
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }

  static makeUserExpert(token) async {
    try {
      Options options = new Options(headers: {
        "Content-Type": "application/json",
        "x-auth-token": token,
      });
      Response response = await Dio().post(
          'https://expertracker.herokuapp.com/api/users/beexpert',
          options: options);
      return response;
    } on DioError catch (e) {
      print('this is begin');
      print(e.message);
      print('this is end');
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return;
  }
}
