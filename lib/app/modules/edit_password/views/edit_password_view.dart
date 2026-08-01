import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_password_controller.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
