import 'package:get/get.dart';

class RoleController extends GetxController {
  RxString role = "".obs;

  void setRole(String value) {
    role.value = value;
  }

  bool get isCustomer => role.value == "customer";
  bool get isProvider => role.value == "provider";
  bool get isDriver => role.value == "driver";
}
