import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
import 'package:untitled2/layout/social_app/social_states.dart';
import 'package:untitled2/models/social_app/postmodel.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (BuildContext context,  state)   {  },
        builder: (BuildContext context, state) {
          return SocialCubit.get(context).posts.isNotEmpty
              ?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: const EdgeInsets.all(8.0),
                  child:Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      const Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/woman-hand-blue-sweater-breaking-through-paper-wall-pointing-copy-space_273609-46465.jpg?t=st=1667652932~exp=1667653532~hmac=3b3eb254738a0db321c2992f4afc9012666ea2121261c3e9eca24f1da7eb1c49'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) => buildPostItem(context,SocialCubit.get(context).posts[index]),
                  separatorBuilder: (context,index) => const SizedBox(height: 8.0,),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                const SizedBox(
                  height:8.0 ,
                ),
              ],
            ),
          )
              :
          const Center(child: CircularProgressIndicator());

        }
    );
  }

  Widget buildPostItem(context, PostModel model) =>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage:  NetworkImage(
                  '${model.image}',
                 ),
              ),
              const SizedBox(width: 15.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(width: 5.0,),
                        const Icon(Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),),
              const SizedBox(width: 15.0,),
              IconButton(
                onPressed:(){},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
              '${model.text}',
             style: Theme.of(context).textTheme.titleMedium,
          ),
           // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10.0,
          //     top: 5.0,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed:  (){},
          //               child: Text('#software',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed:  (){},
          //               child: Text('#software',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
           Padding(
            padding: const EdgeInsetsDirectional.only(top: 15.0,),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0,),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://img.freepik.com/free-photo/woman-hand-blue-sweater-breaking-through-paper-wall-pointing-copy-space_273609-46465.jpg?t=st=1667652932~exp=1667653532~hmac=3b3eb254738a0db321c2992f4afc9012666ea2121261c3e9eca24f1da7eb1c49'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_outline_sharp,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5.0,),
                          Text('0',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.mode_comment_outlined,
                            size: 16.0,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 5.0,),
                          Text('0 comment',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row (
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 10.0,
                        backgroundImage:  NetworkImage(
                            '${SocialCubit.get(context).model!.image}',
                         ),
                      ),
                      const SizedBox(width: 15.0,),
                      Text(
                        'write comment...',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(Icons.favorite_outline_sharp,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 5.0,),
                    Text('Like',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                onTap: (){},
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.share_rounded,
                        size: 16.0,
                        color: Colors.yellow,
                      ),
                      const SizedBox(width: 5.0,),
                      Text('Share',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                onTap: (){},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
