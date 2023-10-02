 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
import 'package:untitled2/layout/social_app/social_states.dart';
import 'package:untitled2/modules/social_app/new_post.dart';
import 'package:untitled2/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getUserData();
    // var model = SocialCubit.get(context).model;
    // if(model == null)print("TRUE");
    // print('++++++++++++++++++++++++');
    // print(model!.name.toString());
    // print(model.isEmailVerified);
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {
        if(state is SocialNewPostState){
          navigateTo(context, NewPost(),);
        }
      },
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
             ),
            actions: [
              IconButton(
                  onPressed: ( ){},
                  icon: const Icon(
                    Icons.notifications,
                  )
              ),
              IconButton(
                  onPressed: ( ){},
                  icon: const Icon(
                    Icons.search,
                  )
              ),
            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_sharp,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.upload_file,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
