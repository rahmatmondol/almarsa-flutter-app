import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/controllers/contact_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    initialFunction();
  }

  Future<void> initialFunction() async {
    await Get.find<ContactPageController>().fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: AppColors.primaryColor,
      ),
      body: GetBuilder<ContactPageController>(
        builder: (controller) {
          return controller.pageLoad
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          "Hi there!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          controller.contactResponseModel.data?.contact ?? "",
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Icon(
                            Icons.phone_android_rounded,
                            size: 50,
                          ),
                        ),
                        Center(
                          child: Text(controller.contactResponseModel.data
                                  ?.contactList?[1].link ??
                              ""),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Icon(
                            Icons.mail_outline_rounded,
                            size: 50,
                          ),
                        ),
                        Center(
                          child: Text(controller.contactResponseModel.data
                                  ?.contactList?[0].link ??
                              ""),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
