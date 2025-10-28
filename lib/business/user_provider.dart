import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userId;
  bool _isAdmin = false;

  String? get userId => _userId;
  bool get isAdmin => _isAdmin;

  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }

  void setIsAdmin(bool value) {
    _isAdmin = value;
    notifyListeners();
  }

  void clearUser() {
    _userId = null;
    _isAdmin = false;
    notifyListeners();
  }
}
