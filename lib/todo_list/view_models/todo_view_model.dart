
import 'package:flutter/cupertino.dart';

class TodoViewModel extends ChangeNotifier{
  bool _isStartDateCalendarVisible = false;
  bool _isEndDateCalendarVisible = false;

  // getters
  bool get isStartDateCalendarVisible => _isStartDateCalendarVisible;
  bool get isEndDateCalendarVisible => _isEndDateCalendarVisible;

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

  // bool isWidgetVisible = true;
  //
  // void toggleVisibility() {
  //   isWidgetVisible = !isWidgetVisible;
  //   notifyListeners();
  // }
}