
abstract class AdminStates{}
class AdminInitialState extends AdminStates{}

class getUnAuthenUsersLoadingState extends AdminStates{}

class getUnAuthenUsersSuccessState extends AdminStates{}

class getUnAuthenUsersErrorState extends AdminStates{}


class AdminloginLoadingState extends AdminStates{}

class AdminloginSuccessState extends AdminStates{
  final String uid ;

  AdminloginSuccessState(this.uid);

}
class AdminloginErrorState extends AdminStates{}

class changePasswardVisiblity extends AdminStates{}
class UpdateFlagSuccessState   extends AdminStates{}
class UpdateFlagErrorState   extends AdminStates{}

class CreateCategorySucccesState extends AdminStates{}

class CreateCategoryErrorState extends AdminStates{}

class CreateCategoryLoadingState extends AdminStates{}