import 'package:elha2ny/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper
{


  static late  SharedPreferences _preferences;

  static Future init() async {
    await SharedPreferences.getInstance().then((value) => _preferences = value) ;
  }


  static Future<dynamic> GetData({required String key}) async
  {
    return  await _preferences.get(key) ;
  }

  static Future<bool> saveData({required String key ,required dynamic value})
  async {

     await init() ;
    if (value is String) return await _preferences.setString(key, value);
    if( value is int) return await _preferences.setInt(key, value);
    if(value is bool) return await _preferences.setBool(key, value);
    return await _preferences.setDouble(key, value);


  }

  static Future<bool> DeleteData({required String key}) async
  {
     return await _preferences.remove(key);
  }


  static Future<void> signOut({required String key})
  async{
    await init() ;
    await _preferences.clear();
  }

}