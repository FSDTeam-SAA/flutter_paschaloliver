import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../conteroller/role_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleController roleController = Get.put(RoleController());

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Obx(() {
          return Text(
            roleController.isProvider ? 'Provider Sign Up' : 'Customer Sign Up',
            style: const TextStyle(fontSize: 22),
          );
        }),
      ),
    );
  }
}
