import 'package:flutter/material.dart';

class TodoViewModel extends ChangeNotifier{
  bool _isStartDateCalendarVisible = false;
  bool _isEndDateCalendarVisible = false;
  bool _isTimeBtnSelected = true;
  bool _isAllDay = false;
  bool _isStartTimeSet = false;
  bool _isEndTimeSet = false;
  bool _isStartClockVisible = false;
  bool _isEndClockVisible = false;

  // getters
  bool get isStartDateCalendarVisible => _isStartDateCalendarVisible;
  bool get isEndDateCalendarVisible => _isEndDateCalendarVisible;
  bool get isTimeBtnSelected => _isTimeBtnSelected;
  bool get isAllDay => _isAllDay;
  bool get isStartTimeSet => _isStartTimeSet;
  bool get isEndTimeSet => _isEndTimeSet;
  bool get isStartClockVisible => _isStartClockVisible;
  bool get isEndClockVisible => _isEndClockVisible;

  // setters
  void toggleStartDateCalendarVisible() {
    _isEndDateCalendarVisible = false;
    _isEndClockVisible = false;
    _isStartDateCalendarVisible = !_isStartDateCalendarVisible;
    notifyListeners();
  }

  void toggleEndDateCalendarVisible() {
    _isStartDateCalendarVisible = false;
    _isEndClockVisible = false;
    _isEndDateCalendarVisible = !_isEndDateCalendarVisible;
    notifyListeners();
  }

  void toggleEndDateClockVisible() {
    _isEndClockVisible = !_isEndClockVisible;
    _isStartClockVisible = false;
    notifyListeners();
  }

  void toggleStartDateClockVisible() {
    _isStartClockVisible = !_isStartClockVisible;
    _isEndClockVisible = false;
    notifyListeners();
  }

  void selectTime() {
    _isTimeBtnSelected = true;
    _isAllDay = false;
    if (isStartDateCalendarVisible) {
      _isStartDateCalendarVisible = false;
      _isStartClockVisible = true;
    } else if (isEndDateCalendarVisible) {
      _isEndDateCalendarVisible = false;
      _isEndClockVisible = true;
    }
    notifyListeners();
  }

  void selectAllDay() {
    _isAllDay = true;
    _isTimeBtnSelected = false;
    if (_isStartClockVisible) {
      _isStartClockVisible = false;
      _isStartDateCalendarVisible = true;
    } else if (isEndClockVisible ) {
      _isEndClockVisible = false;
      _isEndDateCalendarVisible = true;
    }
    notifyListeners();
  }

  String addOneHour(String time) {
    var [String hour, String minute] = time.split(':');
    int hourToInteger = int.parse(hour);
    int hourPlusOne = hourToInteger + 1;

    switch (hourToInteger) {
      case == 23:
        return '00:$minute';
      default :
        return '$hourPlusOne:$minute';
    }
  }


}