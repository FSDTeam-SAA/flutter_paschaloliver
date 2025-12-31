import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:paschaloliver/feature/auth/view/sign_in_view.dart';

import '../../../core/constants/assets.dart';

class HandyResetPasswordScreen extends StatefulWidget {
  const HandyResetPasswordScreen({super.key});

  @override
  State<HandyResetPasswordScreen> createState() =>
      _HandyResetPasswordScreenState();
}

class _HandyResetPasswordScreenState extends State<HandyResetPasswordScreen> {
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;

  Color get _brandGreen => const Color(0xFF27AE60);
  Color get _fieldBorder => const Color(0xFFDDDDDD);
  Color get _textColor => const Color(0xFF222222);
  Color get _hintColor => const Color(0xFFB9B9B9);

  @override
  void dispose() {
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, paddingTop + 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ---------------- LOGO ----------------
              const SizedBox(height: 8),
              SizedBox(
                height: 90,
                child: Image.asset(
                  Images.appLogo, // 🔁 change to your logo path
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'HandyNaija',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: _brandGreen,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 28),

              // ---------------- TITLE ----------------
              Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: _textColor,
                ),
              ),
              const SizedBox(height: 28),

              // ---------------- NEW PASSWORD ----------------
              _buildLabel('New Password'),
              const SizedBox(height: 6),
              _buildPasswordField(
                controller: _newPassCtrl,
                obscure: _obscureNew,
                onToggle: () {
                  setState(() => _obscureNew = !_obscureNew);
                },
              ),
              const SizedBox(height: 18),

              // ---------------- CONFIRM PASSWORD ----------------
              _buildLabel('Confirm New Password'),
              const SizedBox(height: 6),
              _buildPasswordField(
                controller: _confirmPassCtrl,
                obscure: _obscureConfirm,
                onToggle: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),
              const SizedBox(height: 28),

              // ---------------- CONTINUE BUTTON ----------------
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brandGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    final newPass = _newPassCtrl.text.trim();
                    final confirm = _confirmPassCtrl.text.trim();

                    Get.to(() => const HandyEmailLoginScreen());
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: '***************',
        hintStyle: TextStyle(
          fontSize: 13,
          color: _hintColor,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 20,
            color: Colors.grey.shade500,
          ),
          onPressed: onToggle,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: _fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: _brandGreen, width: 1.4),
        ),
      ),
    );
  }
}
