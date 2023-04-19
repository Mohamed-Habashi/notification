
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notification/shared/dio_helper.dart';


import '../../login_screen/login_screen.dart';
import '../../models/user_model.dart';
import '../../shared/cache_helper.dart';
import '../../shared/const.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);




  UserModel? userModel;



  getUserData(String id) {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }
  double? lang;
  double ?lat;

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition().then((value){
      lang=value.longitude;
      lat=value.latitude;
      getDeviceToken(lang:value.latitude, lat:value.longitude);
      emit(SocialGetLikeSuccessState());
    });
  }

  Future getDeviceToken({double? lang, double? lat}) async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken().then((value){
      DioHelper.postData(
        url: 'fcm/send',
        data: {
          'to':'$value',
          'notification':{
            "body" : "$lat",
            "title": "$lang"
          }
        },
      ).then((value){
      });
    });
    return (deviceToken == null) ? "" : deviceToken;
  }


  signOut(context) {
    emit(UserLogoutLoadingState());
    CacheHelper.removeKey(key: 'uId').then((value) {
      navigateToFinish(context, const LoginScreen());
      emit(UserLogoutSuccessState());
    }).catchError((error) {
      emit(UserLogoutErrorState());
    });
  }
}
