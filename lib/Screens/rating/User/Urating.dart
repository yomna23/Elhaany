import 'package:elha2ny/Model/UserModel.dart';
import 'package:elha2ny/Screens/HomePage/Home_Page.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class UserRating extends StatelessWidget {
final UserModel reciver ;

  const UserRating(this.reciver) ;


  @override
  Widget build(BuildContext context) {


    return BlocConsumer<ElhaanyCubit,ELhaanyStates>
      ( listener:(context,state){},
        builder: (context,state){
          var usabilityrating = 0.0;
          var TimeConsume = 0.0 ;
          var Service = 0.0 ;
          var userBehave = 0.0 ;
          var cost = 0.0 ;
          var safety = 0.0 ;

          return Scaffold(
              appBar: AppBar(
                leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.pink,),onPressed: (){},),
                title: Text('Rating page',style: TextStyle(color: Colors.black,fontSize: 16.0),),
              ),
              body:Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(

                    children: [
                      Text('Usability of the system',style: TextStyle(color: Colors.black,fontSize: 16.0),),
                      SmoothStarRating(
                        rating: 0.0,
                        isReadOnly: false,
                        size: 40,
                        filledIconData: Icons.star, color: Colors.pink.withOpacity(0.8),
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,borderColor: Colors.pink.withOpacity(0.3),
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          usabilityrating = value ;
                          print("rating value -> $usabilityrating");
                          //print("rating value dd -> ${value.truncate()}");

                        },
                      ),
                      SizedBox(height :20.0),
                      Text('Time Consume',style: TextStyle(color: Colors.black,fontSize: 16.0),),
                      SmoothStarRating(
                        rating: 0.0,
                        isReadOnly: false,
                        size: 40,
                        filledIconData: Icons.star, color: Colors.pink.withOpacity(0.8),
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,borderColor: Colors.pink.withOpacity(0.3),
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          TimeConsume = value ;
                          print("rating value -> $TimeConsume");
                          //print("rating value dd -> ${value.truncate()}");

                        },
                      ),
                      SizedBox(height: 20.0),
                      Text('Service',style: TextStyle(color: Colors.black,fontSize: 16.0),),
                      SmoothStarRating(
                        rating: 0.0,
                        isReadOnly: false,
                        size: 40,
                        filledIconData: Icons.star, color: Colors.pink.withOpacity(0.8),
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,borderColor: Colors.pink.withOpacity(0.3),
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          Service = value ;
                          print("rating value -> $Service");
                          //print("rating value dd -> ${value.truncate()}");

                        },
                      ),
                      SizedBox(height: 20.0),
                      Text('User behave',style: TextStyle(color: Colors.black,fontSize: 16.0),),
                      SmoothStarRating(
                        rating:0.0,
                        isReadOnly: false,
                        size: 40,
                        filledIconData: Icons.star, color: Colors.pink.withOpacity(0.8),
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,borderColor: Colors.pink.withOpacity(0.3),
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          userBehave = value ;
                          print("rating value -> $userBehave");
                          //print("rating value dd -> ${value.truncate()}");

                        },
                      ),
                      SizedBox(height: 20.0),
                      Text('Cost of the service',style: TextStyle(color: Colors.black,fontSize: 16.0),),
                      SmoothStarRating(
                        rating:0.0,
                        isReadOnly: false,
                        size: 40,
                        filledIconData: Icons.star, color: Colors.pink.withOpacity(0.8),
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,borderColor: Colors.pink.withOpacity(0.3),
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          cost = value ;
                          print("rating value -> $cost");
                          //print("rating value dd -> ${value.truncate()}");

                        },
                      ),
                      SizedBox(height: 20.0),
                      Text('safety',style: TextStyle(color: Colors.black,fontSize: 16.0),),
                      SmoothStarRating(
                        rating:0.0,
                        isReadOnly: false,
                        size: 40,
                        filledIconData: Icons.star, color: Colors.pink.withOpacity(0.8),
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,borderColor: Colors.pink.withOpacity(0.3),
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {
                          safety = value ;
                          print("rating value -> $safety");
                          //print("rating value dd -> ${value.truncate()}");

                        },
                      ),

                      SizedBox(height: 40.0),
                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          primary:Colors.pink,
                          padding: EdgeInsets.fromLTRB(85, 15, 85, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // <-- Radius
                          ),
                        ),

                        onPressed: () async{


                          await ElhaanyCubit.get(context).UpdateUserRate(usabilityRate: usabilityrating, TimeRate: TimeConsume, ServiceRate: Service,
                              userBehaveRate:userBehave, costRate:cost, safety: safety,reciver: reciver);

                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage() ));

                        },
                        child: Text("Rate"), ) ,


                    ],
                  ),
                ),
              )




          );


        });



  }
}