
import 'package:get/get.dart';

class AccountController extends GetxController {
  var welcome = 'Welcome Back'.obs;

  setWelcome(String welcomeMsg) {
    welcome.value = welcomeMsg;
  }

  
}