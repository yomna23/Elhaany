import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elha2ny/Model/CategoryModel.dart';
import 'package:elha2ny/Screens/UserCards/User_Card.dart';

import 'package:elha2ny/components/RoundedDescriptionField.dart';
import 'package:elha2ny/components/WholeAppCubit/AppCubit.dart';
import 'package:elha2ny/components/WholeAppCubit/AppStates.dart';
import 'package:flutter/material.dart';
import 'package:elha2ny/components/app_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../constants.dart';



class Homepage extends StatelessWidget {

  var Desc = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return  BlocConsumer<ElhaanyCubit,ELhaanyStates>(
      listener: (context,state) async {
        if (state is ElhaanyIntialState) {
          await ElhaanyCubit.get(context).getMyLocation().whenComplete(() {
            ElhaanyCubit
                .get(context)
                .myLocation;
          });
        }

      },
      builder: (context,state){

        late GoogleMapController _googleMapController;
        var dropDownValue = ElhaanyCubit.get(context).dropdownValue ;
        var dropDownList = ElhaanyCubit.get(context).catModel.toList();
        var latitude = ElhaanyCubit.get(context).myLocation.latitude ;
        var longitude = ElhaanyCubit.get(context).myLocation.longitude ;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer:AppDrawer(),
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                SlidingUpPanel(

                  maxHeight: 350,


                  panel: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(
                            0,
                            0,
                            0,
                            0.15,
                          ),
                          blurRadius: 25.0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "What Kind of Help You Want ?",
                          style: _theme.textTheme.title,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Slide Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        DropdownButton<String>(
                          value: dropDownValue,
                          isExpanded: true,
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.pink,
                          ),
                          onChanged: (newValue) {

                            ElhaanyCubit.get(context).ChangeDropDownValue(newValue!);


                          },
                          items: dropDownList.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value.catname,
                              child: Text(value.catname),
                            );
                          }).toList(),
                        ),

                        RoundedDescriptionField(
                          cont: Desc,
                          hintText: "Enter Problem Description",
                          onChanged: (value) {},
                          keyboard: TextInputType.text,
                        ),

                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(


                                  style: ElevatedButton.styleFrom(


                                    primary: Colors.pink,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20), // <-- Radius
                                    ),
                                  ),

                                  onPressed: () async {

                                     await ElhaanyCubit.get(context).CreateRequest(Uid: uId , catName: dropDownValue, Desc:Desc.text, time:DateTime.now(), latitude:latitude, longitude: longitude);
                                    print('drop down valueeeeeeeeeeeeeeeeeeeeeeeeeee $dropDownValue');

                                    await ElhaanyCubit.get(context).getAvailableUsers(CatName:dropDownValue) ;
                                    Navigator.push(context, MaterialPageRoute(builder: (Context)=> UserCards()));

                                    //ElhaanyCubit.get(context).GetAllHelpers(CatName: dropDownValue);
                                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatsScreen()));
                                  },
                                  child: Text("Request Help"), ),
                              ),
                              SizedBox(width: 5.0,),
                              Expanded(
                                  child: ElevatedButton(


                                    style: ElevatedButton.styleFrom(


                                      primary: Colors.pink,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20), // <-- Radius
                                      ),
                                    ),

                                    onPressed: () async{

                                      await ElhaanyCubit.get(context).UpdateUserLocation() ;
                                      //  Navigator.push(context, Materian  lPageRoute(builder: (context)=>ChatsScreen()));
                                    },
                                    child: Text("Helping Mode"), ))
                            ],
                          ),
                        )
                        ,
                      ],
                    ),
                  ),

                  body: Stack(
                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height - 140.0,
                          child: GoogleMap(
                            onLongPress: ElhaanyCubit.get(context).addMarker,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            markers: {ElhaanyCubit.get(context).origin},
                            onMapCreated: (controller) =>
                            _googleMapController = controller,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(30.0444, 31.2357),
                              zoom: 11.0,
                            ),
                          )),
                      Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: Icon(
                              Icons.menu,
                              size: 35.0,
                            ),
                            onPressed: () {

                              Scaffold.of(context).openDrawer();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),


        );






      },

    );


  }


}