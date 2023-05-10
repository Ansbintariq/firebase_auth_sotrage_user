import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth_getx_localization/components/helper/localization_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late StreamSubscription subscription;
  Rx isDeviceConected = false.obs;
  RxBool isAlertSet = false.obs;

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConected.value =
            await InternetConnectionChecker().hasConnection;
        if (!isDeviceConected.value && isAlertSet.value == false) {
          showAlertBox();

          isAlertSet.value = true;
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getConnectivity();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed("/login");
              },
              child: Text(
                  AppLocalizations.of(context)?.translate('hello') ?? "null"),
            ),
          )
        ],
      ),
    );
  }

  showAlertBox() {
    showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text("internet error"),
              content: Text("please check your internet connection"),
              actions: [
                TextButton(
                    onPressed: () async {
                      Get.back();

                      isAlertSet.value = false;
                      isDeviceConected.value =
                          await InternetConnectionChecker().hasConnection;
                      if (!isDeviceConected.value) {
                        showAlertBox();

                        isAlertSet.value = true;
                      }
                    },
                    child: Text("OK"))
              ],
            ));
  }
}
