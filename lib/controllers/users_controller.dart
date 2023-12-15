import 'package:get/get.dart';
import 'package:xcrowme/models/users_modal.dart';

class UserController extends GetxController {
  UserModel? user;

  void setUser(UserModel userModel) {
    user = userModel;
    update(); // Notify listeners that the user data has been updated
  }
}