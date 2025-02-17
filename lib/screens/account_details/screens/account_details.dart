import 'package:almarsa/constants/app_colors.dart';
import 'package:flutter/material.dart';

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
    required String subTitle,
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
          subTitle: subTitle,
        ),
      ),
    );
  }

  ListTile _buildInfoListTile({
    required String title,
    required Icon icon,
    required String subTitle,
  }) {
    return ListTile(
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
    );
  }
}
