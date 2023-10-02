abstract class SocialStates {}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetSearchLoadingState extends SocialStates{}

class SocialGetSearchSuccessState extends SocialStates{}

class SocialGetSearchErrorState extends SocialStates{
  final String error;
  SocialGetSearchErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}
class SocialUserUpdateLoadingState extends SocialStates{}
//profile image
class SocialPickProfileImageSuccessState extends SocialStates{}
class SocialPickProfileImageErrorState extends SocialStates{}
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}
//coverImage
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}
class SocialUpdateCoverImageErrorState extends SocialStates{}
class SocialUploadCoverLoadingState extends SocialStates{}
class SocialPickCoverImageSuccessState extends SocialStates{}
class SocialPickCoverImageErrorState extends SocialStates{}

class SocialUpdateDataLoadingState extends SocialStates{}

class SocialUploadImageLoadingState extends SocialStates{}
//create post
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}
//postImage
class SocialPickPostImageSuccessState extends SocialStates{}
class SocialPickPostImageErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}
//get posts
class SocialGetSocialPostsSuccessState extends SocialStates{}

class SocialGetSocialPostsLoadingState extends SocialStates{}

class SocialGetSocialPostsErrorState extends SocialStates
{
  final String? error;
  SocialGetSocialPostsErrorState(this.error);
}
//
// class SocialLikePostSuccessState extends SocialStates{}
// class SocialLikePostErrorState extends SocialStates{}
//
class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates
{
  final String? error;
  SocialGetAllUsersErrorState(this.error);
}
//chat
class SendMessageSuccessState extends SocialStates{}
class SendMessageErrorState extends SocialStates{}
class GetMessagesSuccessState extends SocialStates{}
class GetMessagesErrorState extends SocialStates{}
// class ChatChangeMessageDateShow extends SocialStates{}

