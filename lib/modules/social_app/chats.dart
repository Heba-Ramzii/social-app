import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
import 'package:untitled2/layout/social_app/social_states.dart';
import 'package:untitled2/models/social_app/social_user_model.dart';
import 'package:untitled2/modules/social_app/chat_details.dart';
import 'package:untitled2/shared/components/components.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
        return  SocialCubit.get(context).users.isNotEmpty
          ?
          ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=> buildChatItem(context,SocialCubit.get(context).users[index]),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: SocialCubit.get(context).users.length,
        )
        : const Center(child: CircularProgressIndicator(),)
        ;
      },
     ) ;
  }

  Widget buildChatItem(context,SocialUserModel model)  => InkWell(
    onTap: (){
      navigateTo(context, ChatDetails(userModel: model),);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage:  NetworkImage(
              '${model.image}'
             ),
          ),
          const SizedBox(width: 15.0,),
          Text(
            '${model.name}',
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
