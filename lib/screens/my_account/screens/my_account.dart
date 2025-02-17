import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/controllers/my_account_controller.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  void initState() {
    super.initState();
    initialPageSetup();
  }

  Future<void> initialPageSetup() async {
    await Get.find<MyAccountController>().fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<MyAccountController>(builder: (controller) {
          return controller.pageLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.textWhite,
                  ),
                )
              : Text(
                  controller.myAccountModel.name ?? "",
                  style: TextStyle(
                    color: AppColors.textWhite,
                  ),
                );
        }),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<MyAccountController>(
          builder: (controller) {
            return controller.pageLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.mail_outline_rounded),
                              const SizedBox(width: 10),
                              Text(controller.myAccountModel.email ?? ""),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone_android),
                              const SizedBox(width: 10),
                              Text(controller.myAccountModel.phone ?? ""),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.history),
                                const SizedBox(width: 10),
                                Text("Order History"),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.editMyAccountPage);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.settings),
                                const SizedBox(width: 10),
                                Text("Edit My Account"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
