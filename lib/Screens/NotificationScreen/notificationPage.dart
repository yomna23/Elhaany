//
//
// import 'dart:convert';
//
// import 'package:elha2ny/Model/UserModel.dart';
// import 'package:elha2ny/Screens/ChatScreen/CommunicationScreen.dart';
// import 'package:elha2ny/Screens/GoogleMap/google.dart';
// import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
// import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart';
//
// import '../../../constants.dart';
//
//
//
// class notificationScreen extends StatelessWidget {
//
//   final int index ;
//   final String helperId ;
//   final UserModel sender ;
//   const notificationScreen(this.index,this.helperId,this.sender) ;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocConsumer<ElhaanyCubit,ELhaanyStates>(
//       listener: (context,state){},
//       builder: (context,state){
//         var distance = ElhaanyCubit.get(context).distanceDifference[index] ;
//         return Scaffold(
//           backgroundColor: Color(0xFFF6E6E6),
//           appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios,color: Colors.pink),
//               onPressed: (){
//                 Navigator.pop(context) ;
//               },
//             ),
//
//             title: Text('Request Page',style: TextStyle(fontSize:23.0,color: Colors.black ),),
//           ),
//           body: SafeArea(
//
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//
//                     Container(
//
//                       padding: EdgeInsets.all(45),
//                       color: Colors.white,
//                       child: Row(
//                         children: [
//
//                           Padding(
//                               padding :EdgeInsets.fromLTRB(10, 0, 30, 100),
//
//
//
//                               child: CircleAvatar(
//                                 backgroundImage: NetworkImage('${sender.image}'),
//
//                               )),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("${sender.name} ",
//                                 style: TextStyle(
//
//
//                                   letterSpacing: 1.25,
//                                   fontSize: 25,
//
//
//
//                                 ),),
//                               Text("Rating: ${sender.rate} ✩",
//                                   style: TextStyle(
//
//
//                                     fontSize: 20,
//                                   )
//
//                               ),
//                               Text(" ${distance} meters Away",
//                                   style: TextStyle(
//
//
//                                     fontSize: 15,
//                                   )),
//
//
//
//                               Row(
//                                 children: [
//
//                                   Padding(
//                                     padding: const EdgeInsets.fromLTRB(0, 45, 25, 5),
//                                     child: ElevatedButton(
//
//
//                                       style: ElevatedButton.styleFrom(
//
//
//                                         primary: Colors.pink,
//
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(20), // <-- Radius
//                                         ),
//                                       ),
//
//                                       onPressed: () async {
//                                       //await  MapUtils.openMap(model.latitude, model.longitude) ;
//
//                                         await ElhaanyCubit.get(context).UpdateRequest(false,helperId);
//                                         Navigator.push(context,MaterialPageRoute(builder: (context)=> CommunicationScreen() ));
//                                       },
//                                       child: Text("Accept"), ),
//                                   ),
//                                   SizedBox(width:5.0 ),
//
//                                   Padding(
//                                     padding: const EdgeInsets.fromLTRB(1, 45, 5, 5),
//                                     child: ElevatedButton(
//
//
//
//                                       style: ElevatedButton.styleFrom(
//
//
//                                         primary: Colors.pink,
//
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(20), // <-- Radius
//                                         ),
//                                       ),
//
//                                       onPressed: () async {
//
//                                       },
//                                       child: Text("Ignore",style: TextStyle(
//
//                                         fontSize: 15,
//
//                                       ), )),
//                                   ),
//
//                                 ],
//
//
//                               )
//
//
//                             ],
//                           ),
//
//
//
//
//
//
//
//                         ],
//
//
//
//                       ),
//                     ),
//
//
//                 ],
//               )
//
//
//           ),
//         );
//
//       },
//     );
//
//   }}
//
