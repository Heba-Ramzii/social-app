import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_cubit.dart';
import 'package:untitled2/modules/social_app/social_login/social_login_cubit.dart';
import 'package:untitled2/modules/social_app/social_login/social_login_states.dart';
import 'package:untitled2/shared/components/constants.dart';
import 'package:untitled2/shared/network/local/cache_helper.dart';

import '../../../layout/social_app/social_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../social_register/social_register.dart';

class SocialLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SocialLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener:  (BuildContext context, state) {
           if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId
            ).then((value){
                uId=state.uId;
                SocialCubit.get(context).getUserData();
                navigateAndFinish(
                  context,
                const SocialLayout(),
              );
            }).catchError((error){});
          }
          },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
               child: Padding(
               padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LOGIN',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: defaultColor,
                    ),
                    ),
                    const SizedBox(
                    height: 15.0,
                    ),
                    Text(
                    'Login now to chat with your friends',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                    ),
                    ),
                    const SizedBox(
                    height: 30.0,
                    ),
                    defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String? value){
                    if(value!.isEmpty)
                    {
                    return 'email must not be empty';
                    }
                    return null;
                    },
                    label: 'Email',
                    prefix: Icons.email_outlined,
                    ),
                    const SizedBox(
                    height: 15.0,
                    ),

                    defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (String? value){
                    if(value!.isEmpty)
                    {
                    return 'password must not be empty';
                    }
                    return null;
                    },
                    label: 'Password',
                    prefix: Icons.lock_outline_rounded,
                    suffix:SocialLoginCubit.get(context).suffix ,
                    isPassword: SocialLoginCubit.get(context).isPassword,
                    onSubmit: (value){
                    if(formKey.currentState!.validate()){
                    SocialLoginCubit.get(context).userLogin(
                        email: emailController.text,
                        password: passwordController.text);
                    }
                    },
                    suffixPressed: (){
                    SocialLoginCubit.get(context).socialchangePasswordVisibility();
                    },
                    ),
                    const SizedBox(
                    height: 15.0,
                    ),
                    state is! SocialLoginLoadingtate? defaultButton(
                    function: (){
                    if(formKey.currentState!.validate()){
                    SocialLoginCubit.get(context).userLogin(
                        email: emailController.text,
                        password: passwordController.text);
                    }
                    },
                    text: 'login',
                    radius: 10.0,
                    isUpperCase: true,
                    ):const Center(child: CircularProgressIndicator()),
                    const SizedBox(
                    height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text(
                      'Don\'t have an account?',
                      ),
                      defaultTextButton(
                      function: ( ){
                      navigateTo(context, SocialRegister());
                      },
                      text: 'register'),
                      ],
                  ),
                ],
              ),
              ),
              ),
              ),
              ),
              );
        },

      ),
    );
      }
}
