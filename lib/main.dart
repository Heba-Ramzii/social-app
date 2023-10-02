import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
 import 'package:untitled2/layout/social_app/social_layout.dart';
 import 'package:untitled2/modules/social_app/social_login/social_login.dart';
import 'package:untitled2/shared/bloc_observer.dart';
import 'package:untitled2/shared/components/components.dart';
import 'package:untitled2/shared/components/constants.dart';
import 'package:untitled2/shared/network/local/cache_helper.dart';
import 'package:untitled2/shared/network/local/dio_helper.dart';
import 'package:untitled2/shared/styles/themes.dart';
import 'firebase_options.dart';


 Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   print('on background message');
   print(message.data.toString());
   showToast(text: 'on background message', state: ToastStates.SUCCESS);

 }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(text: 'on message', state: ToastStates.SUCCESS);
   });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.SUCCESS);

  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget widget;

  bool? isDark = CacheHelper.getData(key: 'isDark');
 // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // بحيث لما ييجي هنا لو القيمه موجوده هيخزنها لو مش موجوده هتبقي ب null
  // فلما عملتي لوج اوت معتبرها ب null لان كان فيها ''
  //token = CacheHelper.getData(key: 'token');
     uId = CacheHelper.getData(key: 'uId');
     print('******');
     print(uId);

   if(uId != null){
    widget = const SocialLayout();
  }else{
    widget = SocialLogin();
    }

  runApp(MyApp(widget));
}
class MyApp extends StatelessWidget {
   final Widget startWidget;
   //final bool isDark;
     const MyApp( this.startWidget, {Key? key} /*this.isDark*/) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       //  BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(
       //   fromShared: isDark,
       // ),),
         BlocProvider(create: (context)=> SocialCubit()..getUserData()..getPost()..getUsers() ,),
      ],
      child:MaterialApp(
      theme: lightTheme,
      darkTheme:darkTheme,
      home:SocialLogin(), //startWidget,
      debugShowCheckedModeBanner: false,
            ),
    );
  }
}
