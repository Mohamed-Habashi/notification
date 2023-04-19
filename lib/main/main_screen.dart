import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/layout/cubit/main_cubit.dart';
import 'package:notification/layout/cubit/main_states.dart';
import 'package:notification/shared/constants.dart';

import '../shared/dio_helper.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    init();
    MainCubit.get(context).determinePosition();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            title: const Text(
              'Location',
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    MainCubit.get(context).signOut(context);
                  },
                  icon: const Icon(Icons.login)
              )
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('${MainCubit.get(context).lat}'),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('${MainCubit.get(context).lang}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  init() async {
    await MainCubit.get(context).getDeviceToken();
  }


}

