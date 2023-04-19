import 'dart:ui';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/register_screen/register_cubit/register_state.dart';

import '../../../shared/constants.dart';
import '../../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  registerUser({
    required String name,
    required String email,
    required String password,
    context,
  }) {
    emit(RegisterUserLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        uId: value.user!.uid,
      );

      emit(RegisterUserSuccessfullyState());
      AnimatedSnackBar.rectangle(
        'Success',
        'RegisterSuccessfully',
        duration: const Duration(milliseconds: 300),
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        brightness: Brightness.light,
      ).show(
        context,
      );
    }).catchError((e) {
      if (e.code == 'weak-password') {
        emit(RegisterUserErrorState());
        AnimatedSnackBar.rectangle('Error', 'Weak password',
                duration: const Duration(milliseconds: 300),
                type: AnimatedSnackBarType.error,
                brightness: Brightness.light,
                mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(
          context,
        );
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterUserErrorState());
        AnimatedSnackBar.rectangle('Error', 'Email already in use',
                duration: const Duration(milliseconds: 300),
                type: AnimatedSnackBarType.error,
                brightness: Brightness.light,
                mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(
          context,
        );
      } else {
        emit(RegisterUserErrorState());
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
    required String email,
    required String image,
    required String uId,
  }) {

    UserModel userModel = UserModel(
      name: name,
      email: email,
      uId: uId,
      image: image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessfullyState());
    }).catchError((error) {
      emit(RegisterCreateUserErrorState());
    });
  }

  bool isPassword = false;
  showPassword() {
    isPassword = !isPassword;
    emit(ShowPasswordSuccessState());
  }
}
