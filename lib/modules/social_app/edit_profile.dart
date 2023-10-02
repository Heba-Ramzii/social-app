 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
import 'package:untitled2/layout/social_app/social_states.dart';
import 'package:untitled2/shared/components/components.dart';

class EditProfile extends StatelessWidget {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController= TextEditingController();

  EditProfile({Key? key}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state)
      {
        var usermodel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text= usermodel!.name!;
        bioController.text= usermodel.bio!;
        phoneController.text= usermodel.phone!;
        return   Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            titleSpacing: 5.0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            actions: [
              defaultTextButton(
                function:  (){
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text
                  );
                },
                text: 'Updata',
              ),
              const SizedBox(width: 15.0,),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.topCenter,
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null ?
                                    NetworkImage('${usermodel.coverImage}'):
                                    FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed:  (){
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 16.0,
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null ?
                                NetworkImage('${usermodel.image}') :
                                FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed:  (){
                               SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).coverImage != null || SocialCubit.get(context).profileImage != null)
                      Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                              function:  (){
                                SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text);
                              },
                              text: 'upload profile',
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                        child:  Column(
                          children: [
                            defaultButton(
                              function:  (){
                                SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text,);
                              },
                              text: 'upload cover',
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).coverImage != null || SocialCubit.get(context).profileImage != null)
                    const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person_rounded,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'bio must not be empty';
                        }
                        return null;
                      },
                      label: 'bio',
                      prefix: Icons.info_outline_rounded,
                  ),const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.text,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'phone number must not be empty';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefix: Icons.phone,
                  ),
                 ],
              ),
            ),
          ),
        );
      },
    );
  }
}
