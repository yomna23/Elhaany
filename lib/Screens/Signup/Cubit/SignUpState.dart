abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}
class RegisterSucccesState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  final String error ;
  RegisterErrorState(this.error) ;

}
class RegisterLoadingState extends RegisterStates{}
class changePasswardVisiblity extends RegisterStates{}


class CreateUserSucccesState extends RegisterStates{}
class CreateUserErrorState extends RegisterStates{}
class GenerateNumberState extends RegisterStates{}

class getImageSuccessState extends RegisterStates{}

class getImageErrorState extends RegisterStates{}
class UpdateLoadingState extends RegisterStates{}

class UploadImagePickerErrorState extends RegisterStates{}
class UploadImagePickerSuccessState extends RegisterStates{}


class UpdateSuccessState  extends RegisterStates{}
class UpdateErrorState extends RegisterStates{}
class GetUserSuccessfulState extends RegisterStates{}

class GetUserErrorState extends RegisterStates{
  final String error ;
  GetUserErrorState(this.error) ;
}