import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';

import '../controllers/auth_gate_controller.dart';

class AuthGateView extends GetView<AuthGateController> {
  const AuthGateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: loadingPage());
  }
}
