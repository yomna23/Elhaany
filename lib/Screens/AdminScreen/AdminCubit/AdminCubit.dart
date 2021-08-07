

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elha2ny/Model/CategoryModel.dart';
import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/Screens/AdminScreen/AdminCubit/AdminState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminStates>
{
  AdminCubit() : super(AdminInitialState());


  static AdminCubit get(context) => BlocProvider.of(context);

  List<UserModel> unAuthenUsers = []  ;
  bool isPassword = true ;
  IconData suffix = Icons.visibility_off ;

  void changeVisiblityPassward(){

    isPassword = !isPassword ;
    suffix= isPassword?Icons.visibility_off:Icons.visibility;

    emit(changePasswardVisiblity());
  }



  Future<void> getAllunthenUser() async
  {
    unAuthenUsers = [] ;

    emit(getUnAuthenUsersLoadingState());
    await FirebaseFirestore.instance.collection('users').where('isAuthenticated',isEqualTo:false).get().then((
        value) {
      print('helllllllllllllllllllllllllllllllllllllllo');
      value.docs.forEach((element) {
       //
        print('value');
        unAuthenUsers.add(UserModel.fromJson(element.data()));
        print('yesss not authenticate') ;

      });
      
      emit(getUnAuthenUsersSuccessState());
    }).catchError((error) {
      emit(getUnAuthenUsersErrorState());
    });
  }

 Future<void> Adminlogin( @required String email, @required String password) async {
    print(email);
    print(password);
    emit(AdminloginLoadingState());
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password)
          .then((value) {

            print('adminnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
        emit(AdminloginSuccessState(value.user!.uid));
      }).catchError((error) {
        print(error.toString());
        emit(AdminloginErrorState());
      });

  }

Future<void> UpdateAuthenticationFlag({required bool flag,required int index})
async{


    UserModel model = UserModel(name:unAuthenUsers[index].name,
        phone: unAuthenUsers[index].phone,
        email: unAuthenUsers[index].email,
        UserNationalId: unAuthenUsers[index].UserNationalId,
        UId: unAuthenUsers[index].UId,
        address: unAuthenUsers[index].address,
        image: unAuthenUsers[index].image,
        skill: unAuthenUsers[index].skill,
        Authenimage: unAuthenUsers[index].Authenimage,
        isAuthenticated: flag,
         rate: unAuthenUsers[index].rate,
         reqNum: unAuthenUsers[index].reqNum,
       latitude: unAuthenUsers[index].latitude,
       longitude: unAuthenUsers[index].longitude,
       Gcode: unAuthenUsers[index].Gcode,
       token: unAuthenUsers[index].token
    ) ;


    await FirebaseFirestore.instance.collection('users').doc(model.UId)
        .update(
         model.getMap())
        .then((value) async {

        await unAuthenUsers.remove(unAuthenUsers[index]);
      emit(UpdateFlagSuccessState());

    })
        .catchError((error) {
      emit(UpdateFlagErrorState());
    });



}



  Future<void> CreateCategory(@required String Catname,
      )
  async {
    CategoryModel model = CategoryModel(Catname);
     emit(CreateCategoryLoadingState());
    await FirebaseFirestore.instance.collection('Categories').add(model.getMap()).then((value){
     emit(CreateCategorySucccesState());
    }).catchError((error){

      print(error.toString());
      emit(CreateCategoryErrorState());
    });


  }



}