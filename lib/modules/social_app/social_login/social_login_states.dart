 
abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState{}

class SocialLoginLoadingtate extends SocialLoginState{}

class SocialLoginSuccessState extends SocialLoginState{
   final String uId;
   SocialLoginSuccessState(this.uId);
 }

class SocialChangePasswordVisibilityState extends SocialLoginState{}

class SocialLoginErrorState extends SocialLoginState{
  final String error;

  SocialLoginErrorState(this.error);
}