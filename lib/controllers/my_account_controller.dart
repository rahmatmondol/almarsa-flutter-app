import 'dart:convert';

import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/models/my_account_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountController extends GetxController {
  bool pageLoading = false;

  late MyAccountModel myAccountModel;

  Future<void> fetchInfo() async {
    pageLoading = true;
    update();

    Dio dio = Dio();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String userInfoString =
        sharedPreferences.getString(AppKeys.userInfoKey) ?? "";

    final userInfo = jsonDecode(userInfoString);

    dio.options.headers['Authorization'] = 'Bearer ${userInfo["token"]}';

    final response = await dio.get(
      Urls.myProfileInfoUrl,
    );

    myAccountModel = MyAccountModel.fromJson(response.data);

    pageLoading = false;
    update();
  }
}
