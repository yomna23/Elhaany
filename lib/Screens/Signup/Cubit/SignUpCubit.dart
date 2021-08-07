import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'SignUpState.dart';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterCubit extends Cubit<RegisterStates>
{

  bool isPassword = true ;
  IconData suffix = Icons.visibility_off ;
  int randomValue=0;
  late String Uid ;
  late String AuthenImgeUrl ;
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void changePasswordVisiblity()
  {
    isPassword = !isPassword ;
    suffix=isPassword?Icons.visibility_off:Icons.visibility;


    emit(changePasswardVisiblity());
  }



  Future<void> Register(@required String name ,
      @required String email,
      @required String password,
      @required String phone,
      @required String NationalId,
      @required double latitude,
      @required double longitude,
      @required int Gcode,
      @required String token
      )
  async {
    emit(RegisterLoadingState());
    print(email);
    print(password);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {

      print(email);
      print(password);
      print(value.user!.uid);
      print(value.user!.email);
      CreateUser(name,email,value.user!.uid,phone,NationalId,AuthenImgeUrl,latitude,longitude,Gcode,token);

    })
        .catchError((error){

      print(error);
      emit(RegisterErrorState(error.toString()));
    });



  }

  Future<void> generateRandom()
  async{

    int MAX = 5000 ;
    randomValue = new Random().nextInt(MAX) ;
    if(randomValue != 0)
      emit(GenerateNumberState());

  }


  Future<void> CreateUser(@required String name,
      @required String email,
      @required String UId,
      @required String phone,
      @required String NationalId,
      @required String Authenimage,
      @required double latitude ,
      @required double longitude,
      @required int Gcode,
      @required String token


      )
  async {
    UserModel model =UserModel(name: name, phone: phone, email: email, UserNationalId:NationalId
        , UId: UId, address:'none',
        image: 'https://cdn.pngsumo.com/index-of-assets-images-default-png-256_256.png',
        skill:'none',Authenimage:Authenimage,isAuthenticated:false,
        rate: 0.0,
        reqNum: 0,
        latitude: latitude,
        longitude: longitude,
        Gcode:Gcode,
        token: token);

    //UserModel(name :name, phone:phone, email:email,User NationalId, UId,'none','https://cdn.pngsumo.com/index-of-assets-images-default-png-256_256.png','none', );
    await FirebaseFirestore.instance.collection('users').doc(UId).set(model.getMap()).then((value){
      emit(CreateUserSucccesState());
    }).catchError((error){

      print(error.toString());
      emit(CreateUserErrorState());
    });


  }

  File AuthenticateUserimage = File('');
  var picker = ImagePicker();

  Future<void> getImageee() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      AuthenticateUserimage = File(pickedFile.path);
      print(pickedFile.path.toString());

      emit(getImageSuccessState());
    }
    else {

      emit(getImageErrorState());
    }
  }




  Future<void> uploadAuthenticationImage() async {

    // emit(UpdateLoadingState());

    await firebase_storage.FirebaseStorage.instance.ref().child('pendingUser/${Uri
        .file(AuthenticateUserimage.path.toString())
        .pathSegments
        .last}')
        .putFile(AuthenticateUserimage).then((value) {

      value.ref.getDownloadURL()
          .then((value)  async {

        if(value != null)
        {

          AuthenImgeUrl=value ;
          emit(UploadImagePickerSuccessState());

          // print(value);
          //updateUserData(name: name, phone: phone, address: address,image: value);
          // print('Upload imageeeeeee from upload profile image');

        }

      }).catchError((error) {
        print(error.toString());
        emit(UploadImagePickerErrorState());

      });
    }).catchError((error) {
      //emit(UploadImagePickerErrorState());
    });

  }

  String? tokenId ;
  Future<String?> getToken() async {


    tokenId = (await FirebaseMessaging.instance.getToken())!;


    print('TooooooooooookeeeeeeeeeeenIDddddddddddddddddddddddddddddddddddddddddddd'+tokenId!);

    return tokenId;



  }









}