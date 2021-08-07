import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elha2ny/Model/CategoryModel.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/Screens/Login/Cubit/LoginState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';



class loginCubit extends Cubit<states>
{
  bool isPassword = true ;
  IconData suffix = Icons.visibility_off ;
  List<CategoryModel> catModel = [];
  String userID = '' ;
  late UserModel user ;
  loginCubit() : super(loginInitialState());
  static loginCubit get(context) => BlocProvider.of(context);

  void changeVisiblityPassward(){

    isPassword = !isPassword ;
    suffix= isPassword?Icons.visibility_off:Icons.visibility;

    emit(changePasswardVisiblity());
  }

  void login( @required String email, @required String password)
   {


     print(email);
     print(password) ;
    emit(loginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {

      userID = value.user!.uid ;
      await getUserData(UID:userID) ;


      emit(loginSuccessState(value.user!.uid));

    }).catchError((error)
    {
      print(error.toString());
      emit(loginErrorState(error.toString()));

    });


  }


  String? tokenId ;
  Future<String?> getToken() async {


    tokenId = (await FirebaseMessaging.instance.getToken())!;


    print('TooooooooooookeeeeeeeeeeenIDddddddddddddddddddddddddddddddddddddddddddd'+tokenId!);

    return tokenId;



  }


  Future<void> getUserData({required String UID}) async {
    emit(GetUserLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(UID)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data() as Map<String, dynamic>);

      emit(GetUserSuccessfulState());

      print('authenticatiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiionn  ${user.isAuthenticated}' ) ;

      if(user.isAuthenticated == true)
        {

          emit(UserAuthenSuccessState()) ;


        }
    }
    ).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }



  }



