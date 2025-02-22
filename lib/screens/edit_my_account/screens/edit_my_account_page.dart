import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/edit_my_account/controller/edit_my_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMyAccountPage extends StatefulWidget {
  const EditMyAccountPage({super.key});

  @override
  State<EditMyAccountPage> createState() => _EditMyAccountPageState();
}

class _EditMyAccountPageState extends State<EditMyAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _addressTEC = TextEditingController();
  final TextEditingController _addressTwoTEC = TextEditingController();
  final TextEditingController _cityTEC = TextEditingController();
  final TextEditingController _countryTEC = TextEditingController();
  final TextEditingController _postalCodeTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _stateTEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _addressTEC.dispose();
    _addressTwoTEC.dispose();
    _cityTEC.dispose();
    _countryTEC.dispose();
    _postalCodeTEC.dispose();
    _phoneTEC.dispose();
    _stateTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit my Profile",
        ),
        actions: [
          Icon(Icons.settings),
        ],
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textWhite,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First name"),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _firstNameTEC,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Required";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Last name"),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _lastNameTEC,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Required";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address"),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _addressTEC,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Required";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address Line 2"),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _addressTwoTEC,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Required";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("City"),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _cityTEC,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Required";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("State"),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _stateTEC,
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Country"),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _countryTEC,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Postal Code"),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: Get.width / 2.3,
                            child: TextFormField(
                              controller: _postalCodeTEC,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "Required";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Phone"),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: Get.width / 2.3,
                            child: TextFormField(
                              controller: _phoneTEC,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return "Required";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<EditMyAccountController>(
                    builder: (controller) {
                      return controller.updateInProgress
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  controller.updateProfile(
                                    firstName: _firstNameTEC.text,
                                    lastName: _lastNameTEC.text,
                                    address: _addressTEC.text,
                                    addressTwo: _addressTwoTEC.text,
                                    city: _cityTEC.text,
                                    country: _countryTEC.text,
                                    postalCode: _postalCodeTEC.text,
                                    phone: _phoneTEC.text,
                                    state: _stateTEC.text,
                                  );
                                }
                              },
                              child: Text("Update"),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
