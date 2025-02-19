import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/controllers/my_account_controller.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:almarsa/screens/account_details/screens/account_details.dart';
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
        title: Text(
          "Account",
          style: TextStyle(
            color: AppColors.textWhite,
          ),
        ),
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
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                AccountDetails(
                                  name: controller.myAccountModel.name ?? "",
                                  address:
                                      controller.myAccountModel.address ?? "",
                                  city: controller.myAccountModel.city ?? "",
                                  phone: controller.myAccountModel.phone ?? "",
                                  email: controller.myAccountModel.email ?? "",
                                ),
                              );
                            },
                            child: Card(
                              color: AppColors.primaryColor,
                              surfaceTintColor: Colors.white,
                              child: _buildInfoListTile(
                                title: "Account Details",
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Card(
                              color: AppColors.primaryColor,
                              surfaceTintColor: Colors.white,
                              child: _buildInfoListTile(
                                title: "Order History",
                                icon: Icon(
                                  Icons.history,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.editMyAccountPage);
                            },
                            child: Card(
                              color: AppColors.primaryColor,
                              surfaceTintColor: Colors.white,
                              child: _buildInfoListTile(
                                title: "Edit My Account",
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.changePassword);
                            },
                            child: Card(
                              color: AppColors.primaryColor,
                              surfaceTintColor: Colors.white,
                              child: _buildInfoListTile(
                                title: "Change password",
                                icon: Icon(
                                  Icons.password,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.contactPage);
                            },
                            child: Card(
                              color: AppColors.primaryColor,
                              surfaceTintColor: Colors.white,
                              child: _buildInfoListTile(
                                title: "Contact Us",
                                icon: Icon(
                                  Icons.contact_mail,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              await controller.logOut();
                              Get.offAllNamed(Routes.bottomNavBarScreen);
                            },
                            child: Card(
                              color: AppColors.primaryColor,
                              surfaceTintColor: Colors.white,
                              child: _buildInfoListTile(
                                title: "Log Out",
                                icon: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ),
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

  ListTile _buildInfoListTile({
    required String title,
    required Icon icon,
  }) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}
