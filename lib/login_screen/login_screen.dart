
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cache_helper.dart';
import '../../shared/const.dart';
import '../main/main_screen.dart';
import '../register_screen/register_screen.dart';
import '../shared/constants.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';



var formKey = GlobalKey<FormState>();

var emailController = TextEditingController();
var passwordController = TextEditingController();



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: uId,
            ).then((value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
                (route) => false,
              );
            });
          }
        },
        builder: (context, state) => Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: Colors.white,
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
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                        obscure: !LoginCubit.get(context).isPassword?true:false,
                        keyboardType: TextInputType.visiblePassword,
                        label: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty ';
                          }
                          return null;
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                            emailController.clear();
                            passwordController.clear();
                          }
                        },
                        prefixIcon:  Icon(
                          Icons.password,
                          color: mainColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            LoginCubit.get(context).showPassword();
                          },
                          icon:!LoginCubit.get(context).isPassword?Icon(
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
                        condition: state is! LoginLoadingState,
                        builder: (context) => defaultButton(
                          backColor: mainColor,
                          label: 'LOGIN',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                context: context,
                              );
                              emailController.clear();
                              passwordController.clear();
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
                            'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const RegisterScreen();
                                }),
                              );
                            },
                            child:  Text(
                              'Register Now',
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
