import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/layout/social_app/social_layout.dart';
import 'package:untitled2/modules/social_app/social_register/social_register_cubit.dart';
import 'package:untitled2/modules/social_app/social_register/social_register_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';


class SocialRegister extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  SocialRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext context) => SocialRegisterCubit(),
       child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
         listener:(BuildContext context, state) {
           if(state is SocialCreateUserSuccessState) {
             navigateAndFinish(context, const SocialLayout());
           }
         } ,
         builder: (BuildContext context, state) {
           return Scaffold(
             appBar: AppBar(),
             body:Center(
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Form(
                     key: formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('REGISTER',
                           style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                             color: defaultColor,
                           ),
                         ),
                         const SizedBox(
                           height: 15.0,
                         ),
                         Text(
                           'Register now to chat with your friends',
                           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                             color: Colors.grey,
                           ),
                         ),
                         const SizedBox(
                           height: 30.0,
                         ),
                         defaultFormField(
                           controller: nameController,
                           type: TextInputType.name,
                           validate: (String? value){
                             if(value!.isEmpty)
                             {
                               return 'Please enter your name';
                             }
                             return null;
                           },
                           label: 'Name',
                           prefix: Icons.person_add,
                         ),
                         const SizedBox(
                           height: 15.0,
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
                           suffix:SocialRegisterCubit.get(context).suffix ,
                           //isPassword: SocialLoginCubit.get(context).isPassword,
                           onSubmit: (value){},
                           suffixPressed: (){
                             //SocialLoginCubit.get(context).changePasswordVisibility();
                           },
                         ),
                         const SizedBox(
                           height: 15.0,
                         ),
                         defaultFormField(
                           controller: phoneController,
                           type: TextInputType.phone,
                           validate: (String? value){
                             if(value!.isEmpty)
                             {
                               return 'Please enter your Phone';
                             }
                             return null;
                           },
                           label: 'Phone',
                           prefix: Icons.phone,
                         ),
                         const SizedBox(
                           height: 15.0,
                         ),
                         state is! SocialRegisterLoadingState ?
                         defaultButton(
                           function: (){
                             if(formKey.currentState!.validate()){
                               SocialRegisterCubit.get(context).userRegister(
                                   name: nameController.text,
                                   email: emailController.text,
                                   password: passwordController.text,
                                   phone:phoneController.text,
                               );
                             }
                           },
                           text: 'Register',
                           radius: 10.0,
                           isUpperCase: true,
                         ):const Center(child: CircularProgressIndicator()),
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
