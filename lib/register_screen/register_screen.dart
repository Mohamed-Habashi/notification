import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/register_screen/register_cubit/register_cubit.dart';
import 'package:notification/register_screen/register_cubit/register_state.dart';

import '../../shared/const.dart';
import '../shared/constants.dart';
var formKey=GlobalKey<FormState>();
var emailController=TextEditingController();
var userController=TextEditingController();
var passwordController=TextEditingController();
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterCreateUserSuccessfullyState){
           Navigator.pop(context);
          }
        },
        builder: (context,state)=>Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Register',
                        style:
                        Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: userController,
                        obscure: false,
                        keyboardType: TextInputType.text,
                        label: 'Username',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty ';
                          }
                          return null;
                        },
                        prefixIcon: Icon(
                          Icons.man,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: emailController,
                        obscure: false,
                        keyboardType: TextInputType.emailAddress,
                        label: 'Email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty ';
                          }
                          return null;
                        },
                        prefixIcon:  Icon(
                          Icons.email,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        obscure: !RegisterCubit.get(context).isPassword?true:false,
                        keyboardType: TextInputType.visiblePassword,
                        onSubmit: (value){
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).registerUser(
                              name: userController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                            userController.clear();
                            emailController.clear();
                            passwordController.clear();
                          }
                        },
                        label: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty ';
                          }
                          return null;
                        },
                        prefixIcon: Icon(
                          Icons.password,
                          color: mainColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            RegisterCubit.get(context).showPassword();
                          },
                          icon:!RegisterCubit.get(context).isPassword?Icon(
                            Icons.visibility,
                            color: mainColor,
                          ):Icon(
                            Icons.visibility_off,
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterUserLoadingState,
                        builder: (context) => defaultButton(
                          backColor: mainColor,
                          label: 'REGISTER',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).registerUser(
                                name: userController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                context: context,
                              );
                            }
                          },
                        ),
                        fallback: (context) =>  Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Login Now',
                              style: TextStyle(
                                color: mainColor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
