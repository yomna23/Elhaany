abstract class ELhaanyStates {}


class ElhaanyIntialState extends ELhaanyStates{}

class GetUserSuccessfulState extends ELhaanyStates{}
class GetUserErrorState extends ELhaanyStates{
  final String error ;

  GetUserErrorState(this.error);

}


class GetReceiverLoadingState extends ELhaanyStates{}
class GetReceiverSuccessfulState extends ELhaanyStates{}
class GetReceiverErrorState extends ELhaanyStates{
  final String error ;

  GetReceiverErrorState(this.error);

}

class SetRatingSuccessState extends ELhaanyStates{}

class ChangeRatingSuccessState extends ELhaanyStates{}
class UpdateRatingSuccessState extends ELhaanyStates{}
class UpdateRatingErrorState extends ELhaanyStates{}

class UpdatenotiRequestSuccessState extends ELhaanyStates{}

class UpdatenotiRequestErrorState extends ELhaanyStates {
  final String error;

  UpdatenotiRequestErrorState(this.error);

}


class UpdateLocationSuccessState extends ELhaanyStates{}
class UpdateLocationErrorState extends ELhaanyStates{}


class GetAllHelpersLoadingState extends ELhaanyStates{}

class GetAllHelpersSuccessState extends ELhaanyStates{}

class GetAllHelpersErrorState extends ELhaanyStates{}

class updateRequestSuccessState extends ELhaanyStates{}
class updateRequestErrorState extends ELhaanyStates{
  final String error ;

  updateRequestErrorState(this.error);

}







class GetUserLoadingState extends ELhaanyStates{}
class ChangeDropdownValue extends ELhaanyStates{}
class ChangeCheckedValue extends ELhaanyStates{}

class getCategorySuccessState extends ELhaanyStates{}
class getCategoryErrorState extends ELhaanyStates{}
class getCategoryLoadingState extends ELhaanyStates{}

class getLocationSuccessState extends ELhaanyStates{}
class getLocationLoadingState extends ELhaanyStates{}
class UpdatePhotoSuccessState extends ELhaanyStates{}
class UpdatePhotoErrorState extends ELhaanyStates{}
class getImageSuccessState extends ELhaanyStates{}
class getImageErrorState extends ELhaanyStates{}
class getImageLoadingState extends ELhaanyStates{}
class UploadImagePickerSucessState  extends ELhaanyStates{}
class UploadImagePickerErrorState  extends ELhaanyStates{}

class ResetPasswordSuccessState extends ELhaanyStates{}

class ResetPasswordErrorState extends ELhaanyStates{}
class UpdateErrorState extends ELhaanyStates{}

class UpdateLoadingState extends ELhaanyStates{}

class UpdateSuccessState extends ELhaanyStates{}
class ChangeDropdownSkillValue extends ELhaanyStates{}

class MakeRequestSuccessState extends ELhaanyStates{}

class MakeRequestErrorState extends ELhaanyStates{}

class MakeRequestLoadingState extends ELhaanyStates{}


class SocialSendMessageSuccessState extends ELhaanyStates{}

class SocialSendMessageErrorState extends ELhaanyStates{}


class SocialGetMessagesSuccessState extends ELhaanyStates{}


class deleteRequestSuccessState extends ELhaanyStates{}

class deleteRequestErrorState extends ELhaanyStates{
  final String error ;

  deleteRequestErrorState(this.error);
}






class getPendingResponsesSuccessState extends ELhaanyStates{}

class getPendingResponsesErrorState extends ELhaanyStates{
  final String error ;

  getPendingResponsesErrorState(this.error);

}




