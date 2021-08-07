abstract class states{}
class loginInitialState extends states{}
class loginSuccessState extends states{
  final String uId ;
  loginSuccessState(this.uId);
}

class loginErrorState extends states{
  final String error ;

  loginErrorState(this.error);


}
class loginLoadingState extends states{}
class changePasswardVisiblity extends states{}

class GetUserSuccessfulState extends states{}
class GetUserErrorState extends states{
  final String error ;

  GetUserErrorState(this.error);

}
class GetUserLoadingState extends states{}
class UserAuthenSuccessState extends states{}