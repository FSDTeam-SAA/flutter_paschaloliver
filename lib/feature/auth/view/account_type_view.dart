import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../conteroller/role_controller.dart';

import 'sign_up_view.dart';

enum AccountType { user, serviceProvider }

class ChooseAccountTypeView extends StatefulWidget {
  const ChooseAccountTypeView({super.key});

  @override
  State<ChooseAccountTypeView> createState() => _ChooseAccountTypeViewState();
}

class _ChooseAccountTypeViewState extends State<ChooseAccountTypeView> {
  AccountType? selectedType;
  final RoleController roleController = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What will you do on HandyNaija?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              "This decision is not final. you can later be both a client and a professional from the same account if you wish.",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 32),

            _accountOption(
              title: 'Book a Service',
              subtitle: '(I am a client)',
              icon: Icons.account_circle_outlined,
              value: AccountType.user,
            ),
            const SizedBox(height: 16),

            _accountOption(
              title: 'Offer Services',
              subtitle: '(I am a professional)',
              icon: Icons.handyman_outlined,
              value: AccountType.serviceProvider,
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: selectedType == null ? null : _continue,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedType == null
                    ? Colors.white
                    : AppColors.appColor,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _continue() {
    final role = selectedType == AccountType.user ? 'customer' : 'provider';

    roleController.setRole(role);
    Get.to(() => SignUpScreen());
  }

  Widget _accountOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required AccountType value,
  }) {
    final isSelected = selectedType == value;

    return GestureDetector(
      onTap: () => setState(() => selectedType = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        //
        //  padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? Colors.black : Colors.white),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 250, 250, 250),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                padding: const EdgeInsets.all(0),
                child: Image.asset(
                  "assets/images/client.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            /*    Radio<AccountType>(
              value: value,
              groupValue: selectedType,
              onChanged: (v) => setState(() => selectedType = v),
              activeColor: AppColors.appColor,
            ), */
          ],
        ),
      ),
    );
  }
}
