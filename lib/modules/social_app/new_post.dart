import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
import 'package:untitled2/layout/social_app/social_states.dart';
import 'package:untitled2/shared/components/components.dart';

class NewPost extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();

  NewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context,  state)   {  },
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
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
                    if(SocialCubit.get(context).postImage == null){
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }else{
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,);
                    }
                  },
                  text: 'Post'
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                 const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(height: 10.0,),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:  NetworkImage(
                          'https://img.freepik.com/free-photo/horizontal-shot-dark-skinned-young-woman-laughs-something-funny-giggles-hilarious-joke-rejoices-positive-event-wear-rosy-hoodie-models-indoor-people-happiness-lifestyle-concept_273609-37715.jpg?t=st=1667646160~exp=1667646760~hmac=a0a807231ab4e7f427fe712ce2ec113ea1c5ddc1289689794d4a81862b0bacec'
                      ),
                    ),
                    SizedBox(width: 15.0,),
                    Expanded(
                      child: Text(
                        'Heba Ramzii',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                if(SocialCubit.get(context).postImage !=null)
                 Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.topCenter,
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed:  (){
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed:  (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                              ),
                              SizedBox(width: 5.0,),
                              Text('add photo'),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed:  (){},
                          child: const Text(
                              '# tags',
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
