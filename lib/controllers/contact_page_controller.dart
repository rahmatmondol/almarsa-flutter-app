import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/screens/contact/model/contact_response_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ContactPageController extends GetxController {
  late ContactResponseModel contactResponseModel;
  bool pageLoad = false;

  Future<void> fetchInfo() async {
    pageLoad = true;
    update();

    Dio dio = Dio();

    final data = await dio.get(Urls.contactUrl);
    contactResponseModel = ContactResponseModel.fromJson(data.data);

    pageLoad = false;
    update();
  }
}
