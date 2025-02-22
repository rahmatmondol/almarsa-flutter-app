import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:almarsa/screens/edit_my_account/controller/edit_my_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({
    super.key,
    required this.name,
    required this.address,
    required this.city,
    required this.phone,
    required this.email,
  });

  final String? name, address, city, phone, email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Details"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textWhite,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoCard(
              title: "Name",
              icon: Icons.person,
              subTitle: name ?? "",
            ),
            _buildInfoCard(
              title: "Location",
              icon: Icons.location_on,
              subTitle: address ?? "",
            ),
            _buildInfoCard(
              title: "City",
              icon: Icons.location_city,
              subTitle: city ?? "",
            ),
            _buildInfoCard(
              title: "Phone",
              icon: Icons.phone_android,
              subTitle: phone ?? "",
            ),
            _buildInfoCard(
              title: "Email",
              icon: Icons.email,
              subTitle: email ?? "",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  await Get.find<EditMyAccountController>().fetchProfileInfo();

                  Get.toNamed(Routes.editMyAccountPage);
                },
                child: Card(
                  color: AppColors.primaryColor,
                  surfaceTintColor: Colors.white,
                  child: _buildAccountInfoListTile(
                    title: "Edit My Account",
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],

          // children: [
          //
          //
          //   _buildInfoListTile(
          //     icon: Icon(
          //       Icons.email,
          //       color: Colors.white,
          //     ),
          //     title: email ?? "",
          //   ),
          // ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required String? subTitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.primaryColor,
        surfaceTintColor: Colors.white,
        child: _buildInfoListTile(
          title: title,
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          subTitle: subTitle ?? '',
        ),
      ),
    );
  }

  Card _buildInfoListTile({
    required String title,
    required Icon icon,
    required String subTitle,
  }) {
    return Card(
      color: AppColors.primaryColor,
      margin: EdgeInsets.zero,
      // Remove card margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Remove border radius
      ),
      elevation: 0,
      // Remove shadow
      child: ListTile(
        leading: icon,
        subtitle: Text(
          subTitle,
          style: TextStyle(
            color: AppColors.textWhite,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

// ListTile _buildInfoListTile({
//   required String title,
//   required Icon icon,
//   required String subTitle,
// }) {
//   return ListTile(
//     leading: icon,
//     subtitle: Text(
//       subTitle,
//       style: TextStyle(
//         color: AppColors.textWhite,
//       ),
//     ),
//     title: Text(
//       title,
//       style: TextStyle(
//         color: AppColors.textWhite,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
// }

  Card _buildAccountInfoListTile({
    required String title,
    required Icon icon,
  }) {
    return Card(
      color: AppColors.primaryColor,
      margin: EdgeInsets.zero,
      // Remove card margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Remove border radius
      ),
      elevation: 0,
      // Remove shadow
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textWhite,
          ),
        ),
      ),
    );
  }
}
