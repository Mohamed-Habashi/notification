import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/layout/cubit/main_cubit.dart';
import 'package:notification/login_screen/login_screen.dart';
import 'package:notification/main/main_screen.dart';
import 'package:notification/shared/bloc_observer.dart';
import 'package:notification/shared/cache_helper.dart';
import 'package:notification/shared/constants.dart';
import 'package:notification/shared/dio_helper.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer =MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  DioHelper.init();
  uId=CacheHelper.getData(key:'uId');
  Widget widget;
  if(uId!=null){
    widget=const MainScreen();
  }else{
    widget=const LoginScreen();
  }
  runApp( MyApp(startPage: widget,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.startPage});
  Widget startPage;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>MainCubit(),
      child: MaterialApp(
        home: startPage,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

