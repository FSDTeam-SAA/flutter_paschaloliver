import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:paschaloliver/feature/auth/view/sign_in_view.dart';

import '../../../core/constants/assets.dart';
import 'handy_login_screen.dart';
import 'otp_screen.dart';

class HandyForgotPasswordScreen extends StatefulWidget {
  const HandyForgotPasswordScreen({super.key});

  @override
  State<HandyForgotPasswordScreen> createState() =>
      _HandyForgotPasswordScreenState();
}

class _HandyForgotPasswordScreenState extends State<HandyForgotPasswordScreen> {
  Color get _brandGreen => const Color(0xFF27AE60);
  Color get _borderColor => const Color(0xFFDDDDDD);
  Color get _textColor => const Color(0xFF222222);

  bool _emailSelected = true; // only one option for now

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
                  Images.appLogo, // TODO: change path
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
              const SizedBox(height: 24),

              // ---------------- TITLE & SUBTITLE ----------------
              Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: _textColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Select which contact details should we used to\nreset your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // ---------------- EMAIL OPTION CARD ----------------
              GestureDetector(
                onTap: () {
                  setState(() => _emailSelected = true);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _emailSelected ? _brandGreen : _borderColor,
                      width: _emailSelected ? 1.4 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.03),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF5F5F5),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.mail_outline_rounded,
                            size: 22,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Via Email:',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'gdg***fsf@azlotv.com',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        _emailSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        size: 20,
                        color: _brandGreen,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

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
                  onPressed: () {                       // 👈 change here
                    Get.to(() => const HandyOtpScreen());
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
              const SizedBox(height: 20),

              // ---------------- REMEMBER PASSWORD ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Remember Password ',
                    style: TextStyle(fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const HandyEmailLoginScreen());
                    },

                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _brandGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
