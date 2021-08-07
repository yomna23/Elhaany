
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class Request {

  late String Uid;
  late String catName ;
  late String Desc ;
  late var time ;
  late var latitude ;
  late var longitude ;
  late bool isPending ;
  late String HId ;
  late String ReqId ;
  late int Distance;


  Request({ required this.Uid, required this.catName, required this.Desc, required this.time,
    required this.latitude, required this.longitude, required this.isPending, required this.HId,required this.ReqId,required this.Distance}) ;


 Request.fromJson(Map<String, dynamic> json)
 {

    Uid = json['Uid'];
    catName = json['catName'];
    Desc = json['Desc'];
    time = json['time'] ;
    latitude = json['latitude'] ;
    longitude = json['longitude'] ;
    isPending = json['isPending'] ;
    HId = json[' HId '] ;
    ReqId = json['ReqId'];
    Distance = json['Distance'] ;



 }

  Map<String, dynamic> getMap() {
    return
      {
        'Uid':Uid ,
        'catName': catName ,
        'Desc' : Desc ,
        'time' :  time,
        'latitude' : latitude ,
        'longitude' :longitude,
        'isPending' : isPending ,
        'HId' : HId,
        'ReqId' : ReqId,
        'Distance' : Distance
      };

    }



}