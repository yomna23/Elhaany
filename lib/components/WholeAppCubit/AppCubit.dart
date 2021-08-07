import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:elha2ny/Model/CategoryModel.dart';
import 'package:elha2ny/Model/RequestModel.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/Model/messageModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import 'AppStates.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ElhaanyCubit extends Cubit <ELhaanyStates> {
  ElhaanyCubit() : super(ElhaanyIntialState());

  static ElhaanyCubit get(context) => BlocProvider.of(context);
  late LatLng myLocation = LatLng(0, 0);

  late UserModel model;
  late Request request ;
  late String  RequestId ;
  List<bool> isChecked = [];
  String UserSkill = '';
  bool flag = false;
  bool isCancel = false ;




  void ChangeCancel()
  {

    isCancel != isCancel  ;
  }

  late Position position;

  void FillCheckedList() {
    for (int i = 0; i < catModel.length; i++) {
      isChecked.add(false);
    }
  }


  List<CategoryModel> catModel = [];
  String dropdownValue = '';

  late Marker origin = Marker(markerId: const MarkerId('origin'));


  void ChangeDropDownValue(String newValue) {
    dropdownValue = newValue;
    emit(ChangeDropdownValue());
  }

  void ChangeDropDownSkillValue(String newValue) {
    UserSkill = newValue;
    emit(ChangeDropdownSkillValue());
  }

  void changeCheckedValue(bool value, index) {
    isChecked[index] = value;
    if (value == true) {
      UserSkill = catModel[index].catname;
    }
    emit(ChangeCheckedValue());
  }

  Future<void> getUserData() async {
    emit(GetUserLoadingState());
    print('el zefttttttttttttttttttttt el id');
    print(uId.toString());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId.toString())
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data() as Map<String, dynamic>);
      print(
          ' get user successfulyyyyyyyyyyyyyyyyyyyyyy yesssssssssssssssssssss');
      print(model.UId);
      emit(GetUserSuccessfulState());
    }
    ).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  Future<void> getMyLocation() async {
    emit(getLocationLoadingState());
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    myLocation = LatLng(position.latitude, position.longitude);
    print('latitudeeeeeeee' + myLocation.latitude.toString());
    print('longtitudeeeeee' + myLocation.longitude.toString());
    emit(getLocationSuccessState());
  }

   List<UserModel> usermodel = [] ;

  Future<void> getPendingUser(@required String uid) async {

    emit(GetUserLoadingState());


    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      usermodel.add(UserModel.fromJson(value.data() as Map<String, dynamic>));

      emit(GetUserSuccessfulState());

    }
    ).catchError((error) {
      emit(GetUserErrorState(error.toString()));

    });



  }





  Future<void> addMarker(myLocation) async {
    origin = Marker(
      markerId: const MarkerId('origin'),
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: myLocation,
    );
  }


  void Move() {
    CameraPosition(
      target: origin.position,
      zoom: 11,
    );
  }


  Future<void> getCategories() async
  {
    emit(getCategoryLoadingState());
    await FirebaseFirestore.instance.collection('Categories').get().then((
        value) {
      value.docs.forEach((element) {
        catModel.add(CategoryModel.fromJson(element.data()));


        print('yesssssssssssssssssssssssssssssssssssssssssssssssssssssss');
      });


      dropdownValue = catModel[0].catname;


      emit(getCategorySuccessState());
    }).catchError((error) {
      emit(getCategoryErrorState());
    });
  }

  File Profileimage = File('');
  var picker = ImagePicker();

  Future<void> getImageee() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Profileimage = await File(pickedFile.path);
      print(pickedFile.path.toString());

      emit(getImageSuccessState());
    }
    else {
      emit(getImageErrorState());
    }
  }


  Future<void> uploadProfileImage({
    required String name,
    required String phone,
    required String address}) async {
    emit(UpdateLoadingState());
    await firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(Profileimage.path.toString())
        .pathSegments
        .last}')
        .putFile(Profileimage).then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        if (value != null) {
          //emit(UploadImagePickerSucessState());
          print(value);
          updateUserData(
              name: name, phone: phone, address: address, image: value);
          // print('Upload imageeeeeee from upload profile image');

        }
      }).catchError((error) {
        print(error.toString());
        emit(UploadImagePickerErrorState());
      });
    }).catchError((error) {
      emit(UploadImagePickerErrorState());
    });
  }


  Future<void> updateUserData({required String name,
    required String phone,
    required String address,
    String? image}) async {
    emit(UpdateLoadingState());

    if (model.skill == 'none') {
      UserModel Usermodel = UserModel(
          name: name,
          phone: phone,
          email: model.email,
          UserNationalId: model.UserNationalId,
          UId: model.UId,
          address: address,
          image: image ?? model.image,
          skill: UserSkill,
          Authenimage: model.Authenimage,
          isAuthenticated: model.isAuthenticated,
          rate: model.rate,
          reqNum: model.reqNum,
          latitude: model.latitude,
          longitude: model.longitude,
          Gcode: model.Gcode,
          token: model.token


      );

      await FirebaseFirestore.instance.collection('users').doc(model.UId)
          .update(
          Usermodel.getMap())
          .then((value) async {
         emit(UpdateSuccessState());
        await getUserData();
      })
          .catchError((error) {
        emit(UpdateErrorState());
      });
    }
    else {
      UserModel Usermodel = UserModel(
          name: name,
          phone: phone,
          email: model.email,
          UserNationalId: model.UserNationalId,
          UId: model.UId,
          address: address,
          image: image ?? model.image,
          skill: model.skill,
          Authenimage: model.Authenimage,
          isAuthenticated: model.isAuthenticated,
          rate: model.rate,
          reqNum: model.reqNum,
          latitude: model.latitude,
          longitude: model.longitude,
          Gcode: model.Gcode,
          token: model.token

      );

      await FirebaseFirestore.instance.collection('users').doc(model.UId)
          .update(
          Usermodel.getMap())
          .then((value) async {
        emit(UpdateSuccessState());
        await getUserData();
      })
          .catchError((error) {
        emit(UpdateErrorState());
      });
    }
  }


  Future<void> ResetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((
        value) {
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      emit(ResetPasswordErrorState());
    });
  }

  Future<void> CreateRequest({required String Uid,
    required String catName,
    required String Desc,
    required DateTime time,
    required double latitude,
    required double longitude

  }) async {
    request = Request(Uid: Uid, catName: catName, Desc: Desc, time: time, latitude: latitude, longitude: longitude,
        isPending: true, HId: '', ReqId: '',Distance: 0) ;

    emit(MakeRequestLoadingState());
    await FirebaseFirestore.instance.collection('Request')
        .add(request.getMap())
        .then((value) async {
          RequestId =  value.id ;
          print('the request iddddddddddddddddddd $RequestId') ;
      emit(MakeRequestSuccessState());
      await getAvailableUsers(CatName:dropdownValue) ;

    }).catchError((error) {
      emit(MakeRequestErrorState());
    });
  }


  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel MesssageModel = MessageModel(
        model.UId, receiverId, dateTime, text);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.UId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(MesssageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.UId)
        .collection('messages')
        .add(MesssageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];


  Future<void> getMessages({
    required String receiverId,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.UId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessState());
    });
  }







  Future<void> UpdateUserRate(
      {required double usabilityRate, required double TimeRate, required double ServiceRate,
        required double userBehaveRate, required double costRate, required double safety,required UserModel reciver}) async {
    print('helllllllllllllllllllllllloo from ratinggggggggggggggggggggggg');

    double totalRate = (usabilityRate + TimeRate + ServiceRate +
        userBehaveRate + costRate + safety) / 30;
    double FinalRate = totalRate + reciver.rate;
    FinalRate = double.parse(FinalRate.toStringAsFixed(1));
    if (reciver.rate < 5) {
      UserModel Usermodel = UserModel(
          name: reciver.name,
          phone: reciver.phone,
          email: reciver.email,
          UserNationalId: reciver.UserNationalId,
          UId: reciver.UId,
          address: reciver.address,
          image: reciver.image,
          skill: reciver.skill,
          Authenimage: reciver.Authenimage,
          isAuthenticated: reciver.isAuthenticated,
          rate: FinalRate,
          reqNum: reciver.reqNum,
          latitude: reciver.latitude,
          longitude: reciver.longitude,
          Gcode: reciver.Gcode,
          token: reciver.token
      );

      await FirebaseFirestore.instance.collection('users').doc(reciver.UId)
          .update(
          Usermodel.getMap())
          .then((value) async {
        emit(UpdateRatingSuccessState());
        await getUserData();
      })
          .catchError((error) {
        emit(UpdateRatingErrorState());
      });
    }
  }


  Future<void> UpdateUserLocation() async {
    double newLatitude = position.latitude;
    double newLongitude = position.longitude;

    UserModel Usermodel = UserModel(
        name: model.name,
        phone: model.phone,
        email: model.email,
        UserNationalId: model.UserNationalId,
        UId: model.UId,
        address: model.address,
        image: model.image,
        skill: model.skill,
        Authenimage: model.Authenimage,
        isAuthenticated: model.isAuthenticated,
        rate: model.rate,
        reqNum: model.reqNum,
        latitude: newLatitude,
        longitude: newLongitude,
        Gcode: model.Gcode,
        token: model.token
    );

    await FirebaseFirestore.instance.collection('users').doc(model.UId)
        .update(
        Usermodel.getMap())
        .then((value) async {
      emit(UpdateLocationSuccessState());
      await getUserData();
    })
        .catchError((error) {
      emit(UpdateLocationErrorState());
    });
  }


  List<UserModel> Helpers = [];
  List<UserModel> AvailableHelpers = [] ;

  Future<void> GetAllHelpers({required String CatName}) async {

    Helpers = [] ;
    emit(GetAllHelpersLoadingState());

    await FirebaseFirestore.instance.collection('users').where(
        'skill', isEqualTo: CatName).get()
        .then((value) {
      value.docs.forEach((element) {

        if (element.data()['UId'] != model.UId)
          Helpers.add(UserModel.fromJson(element.data()));





      }

      );
      // print('the name of user ${Helpers.length}');
      emit(GetAllHelpersSuccessState());
    }).catchError((error){


      emit(GetAllHelpersErrorState());


    });
  }



  List<int> distanceDifference = [] ;

  Future<void> getAvailableUsers({required String CatName})
  async {


    await GetAllHelpers(CatName:CatName);
    AvailableHelpers = [];
    distanceDifference = [] ;
    print('the size of helpers listttttttttttttttttttttttttt ${Helpers.length}');
    for(int i=0 ; i<Helpers.length ; i++)
    {

      double latitude = Helpers[i].latitude ;
      double longitude = Helpers[i].longitude ;

      double distance= await Geolocator.distanceBetween(position.latitude,position.longitude,latitude,longitude);
      print('the distance is ${distance}');

    //  if(distance.round() < 5000 )
      //{

        AvailableHelpers.add(Helpers[i]) ;
        distanceDifference.add(distance.round());
        // print('the distance is ${distanceDifference[i]}');


      //}
    }




  }


 Future<void> UpdateRequest(@required bool isPending , @required String HId ,@required int dis)
  async{

    request = Request(Uid: request.Uid,
        catName: request.catName,
        Desc: request.Desc,
        time: request.time,
        latitude: request.latitude,
        longitude: request.longitude,
        isPending: isPending,
        HId: HId,
        ReqId: RequestId ,
        Distance: dis

    ) ;

    print('the requesttttttttttttttt iddddddddddddddddddd $RequestId');
    print('the distanceeeeeeeeeeeeeeeeeeeeeeeeee $dis');
    print('the helper iddddddddddddddddddddd $HId') ;




    await FirebaseFirestore.instance.collection('Request').doc(request.ReqId)
        .update(
        request.getMap()).then((value) {

          emit(updateRequestSuccessState());

    }).catchError((error){


      emit(updateRequestErrorState(error.toString()));

    });


  }




  Future<void> UpdateRequestnoti(
      @required String uid , @required String catName ,@required String Desc,
  @required var time , @required double latitude,  @required double  longitude,
      @required String RID,@required bool isPending , @required String HId ,@required int dis)
  async{

    Request request = Request(Uid: uid,
        catName: catName,
        Desc: Desc,
        time: time,
        latitude: latitude,
        longitude: longitude ,
        isPending: isPending,
        HId: HId,
        ReqId: RID ,
        Distance: dis

    ) ;

    await FirebaseFirestore.instance.collection('Request').doc(RID)
        .update(
        request.getMap()).then((value) {

      emit(UpdatenotiRequestSuccessState());

    }).catchError((error){


      emit(UpdatenotiRequestErrorState(error.toString()));

    });


  }



  Future<void> RemoveRequest(String RequestId )
 async {


    await FirebaseFirestore.instance.collection("Request")
       .doc(RequestId)
       .delete().then((value){



         print('the deleteeeeeeeeeeeed request is $RequestId') ;
      emit(deleteRequestSuccessState());


    }).catchError((error){

    emit(deleteRequestErrorState(error.toString()));
    }) ;

  }



  //where('isPending',isEqualTo:true )
  //where(
  //         'HId', isEqualTo: model.UId)
  List<Request> pendingResponses = []  ;
  Future<void> getPendingResponse ()
  async {


    pendingResponses = [] ;
    await FirebaseFirestore.instance.collection("Request").where('isPending',isEqualTo:true ).where('HId',isEqualTo:model.UId).get().then((value) async {

      value.docs.forEach((element) async {

        print('the valueeeeeeeeeeeeeeee');
        print(element.data()['isPending']);
        pendingResponses.add(Request.fromJson(element.data()));

      });


      print('the pending size is ');
      print(pendingResponses.length);

      emit(getPendingResponsesSuccessState());



    }).catchError((error){
      emit(getPendingResponsesErrorState(error.toString())) ;

    });

  }

  Future<void> loopPendngUserRequest()
  async {


    for(int i=0 ; i< pendingResponses.length ; i++) {

      String id = pendingResponses[i].Uid ;

      await getPendingUser(id)  ;
      print('heyyyyyyyyyyy');

    }


    print('useeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeerr');


  }



























}