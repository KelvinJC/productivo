import 'package:flutter/material.dart';

class TodoViewModel extends ChangeNotifier{
  bool _isStartDateCalendarVisible = false;
  bool _isEndDateCalendarVisible = false;
  bool _isTimeSelected = true;
  bool _isAllDay = false;

  // getters
  bool get isStartDateCalendarVisible => _isStartDateCalendarVisible;
  bool get isEndDateCalendarVisible => _isEndDateCalendarVisible;
  bool get isTimeSelected => _isTimeSelected;
  bool get isAllDay => _isAllDay;


  // setters
  void toggleStartDateCalendarVisible() {
    _isEndDateCalendarVisible = false;
    _isStartDateCalendarVisible = !_isStartDateCalendarVisible;
    notifyListeners();
  }

  void toggleEndDateCalendarVisible() {
    _isStartDateCalendarVisible = false;
    _isEndDateCalendarVisible = !_isEndDateCalendarVisible;
    notifyListeners();
  }

  void selectTime() {
    if (!_isTimeSelected) {
      _isTimeSelected = true;
      _isAllDay = false;
    }
    notifyListeners();

  }

  void selectAllDay() {
    if (!_isAllDay) {
      _isAllDay = true;
      _isTimeSelected = false;
    }
    notifyListeners();

  }


}