import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../conteroller/role_controller.dart';

import 'sign_up_view.dart';

enum AccountType { user, serviceProvider }

class ChooseAccountTypeView extends StatefulWidget {
  const ChooseAccountTypeView({super.key});

  @override
  State<ChooseAccountTypeView> createState() =>
      _ChooseAccountTypeViewState();
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
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Account Type',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            _accountOption(
              title: 'User',
              subtitle: 'Someone who receives services',
              icon: Icons.account_circle_outlined,
              value: AccountType.user,
            ),
            const SizedBox(height: 16),

            _accountOption(
              title: 'Service Provider',
              subtitle: 'Someone who provides services',
              icon: Icons.handyman_outlined,
              value: AccountType.serviceProvider,
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: selectedType == null ? null : _continue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appColor,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _continue() {
    final role =
        selectedType == AccountType.user ? 'customer' : 'provider';

    roleController.setRole(role);
    Get.to(() =>  SignUpView());
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFEEFE7) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.appColor : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.appColor.withOpacity(0.15),
              child: Icon(icon, color: AppColors.appColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            Radio<AccountType>(
              value: value,
              groupValue: selectedType,
              onChanged: (v) => setState(() => selectedType = v),
              activeColor: AppColors.appColor,
            ),
          ],
        ),
      ),
    );
  }
}
