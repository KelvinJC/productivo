import 'package:flutter/material.dart';

class LocationViewModel extends ChangeNotifier {
  bool _isLocationFieldSelected = false;



  //getters
  bool get isLocationFieldSelected => _isLocationFieldSelected;




  // setters
  void toggleLocationFieldSelected() {
    _isLocationFieldSelected = !_isLocationFieldSelected;
    notifyListeners();
  }


}