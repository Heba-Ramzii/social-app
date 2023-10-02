
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/models/social_app/social_user_model.dart';
import 'package:untitled2/modules/social_app/social_register/social_register_states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit(): super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

   late bool status;
  IconData prefix =Icons.lock_outline;
  IconData suffix = Icons.visibility_outlined;
  bool shown = true;
  void pass()
   {
    shown = !shown;
    suffix = shown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    prefix = shown
        ? Icons.lock_outline
        : Icons.lock_open_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }


  void userRegister({
    required String email,
    required String password,
    required String name,
     required String phone})
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          email: email,
          name: name,
          phone: phone,
           uId: value.user!.uid
      );
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));

    } );

  }

  void userCreate ({
    required String email,
     required String name,
    required String phone,
    required String uId,
   })
  {
    SocialUserModel model =SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write you bio....',
      image: 'https://img.freepik.com/free-photo/photo-handsome-male-student-his-female-groupmate-demonstrates-okay-gesture-agree-with-something_273609-24806.jpg?t=st=1667811257~exp=1667811857~hmac=f65a7b6d1f818935fdad5d07afb4daabba7a070c318674c836d03c8aa007b98f',
      coverImage: 'https://img.freepik.com/free-photo/photo-handsome-male-student-his-female-groupmate-demonstrates-okay-gesture-agree-with-something_273609-24806.jpg?t=st=1667811257~exp=1667811857~hmac=f65a7b6d1f818935fdad5d07afb4daabba7a070c318674c836d03c8aa007b98f',
      isEmailVerified: false,
    );
     FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
            emit(SocialCreateUserSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(SocialCreateUserErrorState(error.toString()));
        } ) ;
  }

}