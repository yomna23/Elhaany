
// Routes
// const String HomePageRoute = "/";
import 'package:elha2ny/Screens/HomePage/Components/body.dart';
import 'package:elha2ny/Screens/Profile/Profile_Page.dart';
import 'package:elha2ny/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

const String WalkthroughRoute = "/";
const String RegisterRoute = "register";
const String LoginRoute = "login";
const String PhoneRegisterRoute = "phone-register";
const String OtpVerificationRoute = "otp-verification";
const String UpdateInformationRoute = "update-information";
const String SelectCountryRoute = "country-select";
const String HomepageRoute = "homepage";
const String DestinationRoute = "destination";
const String UnAuthenticatedPageRoute = "unauth";
const String ProfileRoute = "profile";
const String PaymentRoute = "payment";
const String AddCardRoute = "addCard";
const String ChatRiderRoute = "chatRider";
const String FavoritesRoute = "favorite";
const String UpdateFavoritesRoute = "update-favorite";
const String PromotionRoute = "promotion";
const String SuggestedRidesRoute = "suggested-route";


// Router
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {

    case HomepageRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Homepage());
    case ProfileRoute:
      return MaterialPageRoute(builder: (context) {
        return UserProfilePage();});
      default:
      return MaterialPageRoute(
          builder: (BuildContext context) => WelcomeScreen());
  }
}
