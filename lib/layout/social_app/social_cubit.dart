import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
 import 'package:untitled2/layout/social_app/social_states.dart';
import 'package:untitled2/models/social_app/postmodel.dart';
import 'package:untitled2/models/social_app/social_user_model.dart';
import 'package:untitled2/modules/social_app/chats.dart';
import 'package:untitled2/modules/social_app/feeds.dart';
import 'package:untitled2/modules/social_app/new_post.dart';
import 'package:untitled2/modules/social_app/settings.dart';
import 'package:untitled2/modules/social_app/users.dart';
import 'package:untitled2/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/social_app/message_model.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() :super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model ;
  void getUserData(){
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users')
        .doc(uId).get()
        .then((value) {
          print("hi");
          print(value.data().toString());
          model = SocialUserModel.fromJson(value.data()!);
          print(model!.name);
          emit(SocialGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });

  }

  int currentIndex = 0;

  List<Widget> screens = [
    const Feeds(),
    const Chats(),
    NewPost(),
    const Users(),
    const SettingsScreens(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav (int index){
    if(index==1) {
      getUsers();
    }
     if(index == 2) {
      emit(SocialNewPostState());

    } else {
      currentIndex=index;
      emit(SocialChangeBottomNavState());
    }
  }

  // image picker
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialPickProfileImageSuccessState());
    }
    else {
      emit(SocialPickProfileImageErrorState());
      print("no image selected");
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialPickCoverImageSuccessState());
    }
    else {
      emit(SocialPickCoverImageErrorState());
      print("no image selected");
    }
  }

   void uploadProfileImage({
     required String name,
     required String bio,
     required String phone,
   }){
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path)
        .pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value){
            //emit(SocialUploadProfileImageSuccessState());
            print(value);
            updateUser(
                name: name,
                bio: bio,
                phone: phone,
              image: value,
            );
           }).catchError((error){
            emit(SocialUploadProfileImageErrorState());
          });
    })
        .catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });}

  void uploadCoverImage({
     required String name,
     required String bio,
     required String phone,
}){
     emit(SocialUserUpdateLoadingState());
     firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path)
        .pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
          value.ref.getDownloadURL().then((value){
            //emit(SocialUploadCoverImageSuccessState());
            print(value);
            updateUser(
              name: name,
              bio: bio,
              phone: phone,
              cover: value,
            );
          }).catchError((error){
            emit(SocialUploadCoverImageErrorState());
          });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
}){
     SocialUserModel userModel = SocialUserModel(
      name: name,
      phone: phone,
      uId: model!.uId,
      bio: bio,
      image:image??model!.image,
      email: model!.email,
      coverImage:cover??model!.coverImage,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  //post
  File? postImage;
  Future<void> getPostImage() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPickPostImageSuccessState());
    } else {
      emit(SocialPickPostImageErrorState());
      print("no image selected");
    }
  }

  void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
     required String dateTime,
    required String text,
   }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path)
        .pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        print(value);
        createPost(
            dateTime: dateTime,
            text: text,
          postImage: value,
        );
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
     required String dateTime,
    required String text,
    String? postImage,
  }){
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      text: text,
      postImage: postImage ?? '',
      dateTime: dateTime ,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
      //postModel.postId = value.id;
      print(value.id);
     })
        .catchError((error) {
          emit(SocialCreatePostErrorState());
     });
  }

  List<PostModel> posts=[];
  void getPost(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          for (var element in value.docs) {
            posts.add(PostModel.fromJson(element.data()));
          }
          emit(SocialGetSocialPostsSuccessState());
    })
        .catchError((error){
          emit(SocialGetSocialPostsErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];
  void getUsers(){
    if(users.isEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        for (var element in value.docs) {
          if(element.data()['uId']!= model!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUsersSuccessState());
        })
          .catchError((error){
        emit(SocialGetAllUsersErrorState(
            error.toString())
        );
      });
    }
  }
  void sendMessage
      ({
    required String dateTime,
    required String text,
    required String receiverId,
  })
  {
    MessageModel message = MessageModel(
        dateTime: dateTime,
        text: text,
        receiverId: receiverId,
        senderId: model!.uId
    );
    //recv chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(message.toMap())
        .then((value)
    {
      emit(SendMessageSuccessState());
    }).catchError((error)
    {
      emit(SendMessageErrorState());
    });
    //my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(message.toMap())
        .then((value)
    {
      emit(SendMessageSuccessState());
    }).catchError((error)
    {
      emit(SendMessageErrorState());
    });
  }

  // void changMessageDateShow(MessageModel messageModel)
  // {
  //   messageModel.dateShow = !messageModel.dateShow;
  //   emit(  ChatChangeMessageDateShow());
  // }
//***************************************
  List<MessageModel> messages=[];
  void getMessages(String receiverId)
  {
    print('object+++++++++++++');
    print(receiverId);
    print(model!.uId!);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
         .orderBy('datetime')
        .snapshots()
        .listen((event)
    {
      print(event.docs.length);
      messages=[];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      print(messages.length);
      emit(GetMessagesSuccessState());
    });
  }

}
