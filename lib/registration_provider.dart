import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  String name = "";
  String email = "";
  String password = "";

  bool isLoading = false;
  String errorMessage = "";

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Name";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || !value.contains("@")) {
      return "Enter Valid Email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Minimum 6 Characters";
    }
    return null;
  }

  Future<bool> register() async {
    isLoading = true;
    errorMessage = "";
    notifyListeners();

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (email == "fail@gmail.com") {
      errorMessage = "Registration Failed!";
      isLoading = false;
      notifyListeners();
      return false;
    }

    isLoading = false;
    notifyListeners();
    return true;
  }
}