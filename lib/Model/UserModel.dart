class UserModel {
  late String name;

  late String phone;

  late String email;

  late String address;

  late String UserNationalId;

  late String UId;

  late String image ;
  late String skill;
  late bool isAuthenticated ;
  late String Authenimage ;
  late double rate ;
  late int reqNum ;
  late double latitude ;
  late double longitude ;
  late int Gcode ;
  late String token ;

  UserModel({required this.name,required this.phone, required this.email,required this.UserNationalId, required this.UId, required this.address,required this.image,required this.skill,
    required this.Authenimage,required this.isAuthenticated,required this.rate,required this.reqNum,required this.latitude,required this.longitude,required this.Gcode,required this.token});



  UserModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    UserNationalId = json['UserNationalId'];
    UId = json['UId'];
    address = json['address'] ;
    image = json['image'] ;
    skill = json['skill'];
    Authenimage = json['Authenimage'];
    isAuthenticated = json['isAuthenticated'];
    rate = json['rate'];
    reqNum = json['reqNum'];
    latitude=json['latitude'] ;
    longitude = json['longitude'] ;
    Gcode = json['Gcode'];
    token = json['token'] ;
  }

  Map<String, dynamic> getMap() {
    return
      {
        'name': name,
        'phone': phone,
        'email': email,
        'UserNationalId': UserNationalId,
        'UId': UId,
        'address' :address ,
        'image' : image,
        'skill' : skill,
        'Authenimage' : Authenimage ,
        'isAuthenticated' : isAuthenticated,
        'rate' : rate,
        'reqNum' : reqNum,
        'latitude': latitude ,
        'longitude' : longitude,
        'Gcode' : Gcode,
        'token' : token

      };
  }






}