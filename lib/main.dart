// @dart=2.9


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopbox/features/branches_screen/branches_screen.dart';
import 'package:shopbox/features/clients_list_screen/clients_screen.dart';
import 'package:shopbox/features/login_screen/login_controller.dart';
import 'package:shopbox/features/login_screen/login_screen.dart';

import 'features/counter_screen/counter_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return GetMaterialApp(
      title: 'Shopbox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [

        GetPage(name: "/clients", page: ()=> ClientScreen()),
        GetPage(name: "/branches", page: ()=> BranchesScreen()),
        GetPage(name: "/login", page: ()=> LoginScreen()),
        GetPage(name: "/counter", page: ()=> CounterScreen()),
      ],
      initialRoute: "/login",
    );
  }
}