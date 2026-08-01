import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/all_resep_controller.dart';

class AllResepView extends GetView<AllResepController> {
  const AllResepView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllResepView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AllResepView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
