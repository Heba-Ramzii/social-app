import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
import 'package:untitled2/layout/social_app/social_states.dart';
import 'package:untitled2/models/social_app/message_model.dart';
import 'package:untitled2/models/social_app/social_user_model.dart';
import 'package:untitled2/shared/styles/colors.dart';

class ChatDetails extends StatelessWidget {
  ScrollController scrollController = ScrollController();
  var messageController = TextEditingController();
 SocialUserModel userModel;
 ChatDetails({Key? key, 
   required this.userModel,
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(userModel.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (BuildContext context, Object? state) {  },
          builder:(BuildContext context, Object? state) {
            return Scaffold(
              appBar:AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel.image!,
                      ),
                    ),
                    const SizedBox(width: 15.0,),
                    Text(
                      userModel.name!,
                    ),
                  ],
                ),
              ) ,
              body:SocialCubit.get(context).messages==0
                  ?
              const Center(child: CircularProgressIndicator())
                :
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder:(context,index){
                          var message = SocialCubit.get(context).messages[index];
                          if(SocialCubit.get(context).model!.uId==message.senderId) {
                            return buildMyMessage(message);
                          }
                          return buildMessage(message);
                        },
                        separatorBuilder: (context,state)=>const SizedBox(height: 15.0,),
                        itemCount:SocialCubit.get(context).messages.length ,
                      ),
                    ),
                    Container (
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),               child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextFormField(
                              controller: messageController,
                              decoration:  const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here ...',
                                //hintStyle: TextStyle(color : Theme.of(context).textTheme.bodyText1!.color!),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          color: defaultColor,
                          child: MaterialButton(
                            onPressed: (){
                              SocialCubit.get(context).sendMessage(
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                                receiverId: userModel.uId!,
                              );
                            },
                            minWidth: 1.0,
                            child: const Icon(
                              Icons.send_outlined,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }

  Widget buildMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          messageModel.text!,
        )),
  );
  Widget buildMyMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(messageModel.text!,)),
  );
}
