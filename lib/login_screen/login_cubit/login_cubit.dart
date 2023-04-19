import 'dart:convert';
import 'dart:ui';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/cache_helper.dart';
import '../../../shared/constants.dart';
import '../../models/user_model.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());


  static LoginCubit get(context) => BlocProvider.of(context);

  userLogin({
    required String email,
    required String password,
    context,
  })  {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value)  {
          uId=value.user?.uid;
      emit(LoginSuccessState(uId!));
      AnimatedSnackBar.rectangle(
        'Success',
        'Login Successfully',
        duration: const Duration(milliseconds: 300),
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        brightness: Brightness.light,
      ).show(
        context,
      );
    }).catchError((e) {

      if (e.code == 'user-not-found') {
        emit(LoginErrorState());
        AnimatedSnackBar.rectangle('Error', e.toString(),
            duration: const Duration(milliseconds: 300),
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(
          context,
        );
      } else if (e.code == 'wrong-password') {

        emit(LoginErrorState());
        AnimatedSnackBar.rectangle('Error', e.toString(),
            duration: const Duration(milliseconds: 300),
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(
          context,
        );
      }else {
        emit(LoginErrorState());
        AnimatedSnackBar.rectangle('Error', e.toString(),
            duration: const Duration(milliseconds: 300),
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(
          context,
        );
      }
    });
  }
  adminLogin({
    required String email,
    required String password,
    context,
  })  {
    emit(AdminLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value)  {
          uId=value.user?.uid;
      emit(AdminLoginSuccessState(uId!));
      AnimatedSnackBar.rectangle(
        'Success',
        'Login Successfully',
        duration: const Duration(milliseconds: 300),
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        brightness: Brightness.light,
      ).show(
        context,
      );
    }).catchError((e) {

      if (e.code == 'user-not-found') {
        emit(AdminLoginErrorState());
        AnimatedSnackBar.rectangle('Error', e.toString(),
            duration: const Duration(milliseconds: 300),
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(
          context,
        );
      } else if (e.code == 'wrong-password') {

        emit(AdminLoginErrorState());
        AnimatedSnackBar.rectangle('Error', e.toString(),
            duration: const Duration(milliseconds: 300),
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(
          context,
        );
      }else {
        emit(LoginErrorState());
        AnimatedSnackBar.rectangle('Error', e.toString(),
            duration: const Duration(milliseconds: 300),
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(
          context,
        );
      }
    });
  }







  userCreate({
    required String name,
    required String image,
    required String email,
    required String uId,
    required context,
}){
    emit(CreateUserLoadingState());
    UserModel userModel=UserModel(
        name: name,
        email: email,
        uId: uId,
        image: image
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value){
      emit(CreateUserSuccessState());
      AnimatedSnackBar.rectangle(
        'Success',
        'Login Successfully',
        duration: const Duration(milliseconds: 300),
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        brightness: Brightness.light,
      ).show(
        context,
      );
    }).catchError((error){
      emit(CreateUserErrorState());
    });
  }

  bool isPassword=false;
  showPassword(){
    isPassword=!isPassword;
    emit(ShowPasswordSuccessState());
  }

}
