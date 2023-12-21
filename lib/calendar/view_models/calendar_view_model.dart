import 'package:flutter/material.dart';

class CalendarViewModel extends ChangeNotifier {
  DateTime _startCalCurrentDay = DateTime.now();
  DateTime _endCalCurrentDay = DateTime.now();
  late var _calendarFormat;

  // getters
  DateTime get startCalCurrentDay => _startCalCurrentDay;
  DateTime get endCalCurrentDay => _endCalCurrentDay;
  dynamic get calendarFormat => _calendarFormat;

  void setStartCalCurrentDay (DateTime day, DateTime focusedDay) {
    _startCalCurrentDay = day;
    if (_startCalCurrentDay.isAfter(_endCalCurrentDay)) {
      _endCalCurrentDay = day;
    }
    notifyListeners();
  }

  void setEndCalCurrentDay (DateTime day, DateTime focusedDay) {
    _endCalCurrentDay = day;
    if (_startCalCurrentDay.isAfter(_endCalCurrentDay)) {
      _startCalCurrentDay = day;
    }
    notifyListeners();
  }

  void setCalendarFormat (format) {
    _calendarFormat = format;
  }


}