import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
import 'package:untitled2/layout/social_app/social_states.dart';
import 'package:untitled2/modules/social_app/drawer.dart';
import 'package:untitled2/modules/social_app/edit_profile.dart';
 import 'package:untitled2/shared/components/components.dart';

class SettingsScreens  extends StatelessWidget {
  const SettingsScreens({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder:(context, state) {
        var usermodel = SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        alignment: AlignmentDirectional.topCenter,
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${usermodel!.coverImage}'
                            ),
                             fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage:  NetworkImage(
                            '${usermodel.image}'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                '${usermodel.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '${usermodel.bio}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        onTap: (){} ,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        onTap: (){} ,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '150',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        onTap: (){} ,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '46',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        onTap: (){} ,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: const Text('Add Photos'),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditProfile());
                    },
                     child: const Icon(
                      Icons.edit_outlined,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed:  (){
                    FirebaseMessaging.instance.subscribeToTopic('announcements');
                  },
                      child: const Text(
                          'subscribe'
                      ),
                  ),
                  const SizedBox(width: 20.0,),
                  OutlinedButton(onPressed:  (){
                    FirebaseMessaging.instance.unsubscribeFromTopic('announcements');

                  },
                      child: const Text(
                          'unsubscribe'
                      ),
                  ),
                ],
              ),
              const SizedBox(width: 20.0,),
              defaultButton(
                  function:(){navigateTo(context, const Drawerr());},
                  text: 'Drawer'
              ),
             ],
          ),
        );
      },
     );
  }
}
