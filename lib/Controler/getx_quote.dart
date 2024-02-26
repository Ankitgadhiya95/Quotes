import 'package:get/get.dart';

class GetxCon extends GetxController {
  Rx<bool> theme = false.obs;

  set isDark(value) {
    theme.value = value;
  }

  get isDark {
    return theme.value;
  }
}
