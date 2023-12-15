import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ClockViewModel extends ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  DateTime _currentDay = DateTime.now();
  late List _splitDate = DateFormat('EEEE, MMMM d y').format(_currentDay).split(', ');
  late String _formattedDate = _splitDate[1];
  late String _formattedDay = _splitDate[0];
  late String _timeOfDay;


  ClockViewModel() {
    Timer.periodic(const Duration(minutes: 1), callEveryMinute);
    Timer.periodic(const Duration(days: 1), callEveryDay);
  }

  void callEveryMinute(timer) {
    _currentTime = DateTime.now();
    notifyListeners();
  }

  void callEveryDay(timer) {
    _currentDay = DateTime.now();
    notifyListeners();
  }


  // getters
  String get formattedDay => _formattedDay;
  String get formattedDate => _formattedDate;
  String get formattedTime {
    if (_currentTime != null) {
      String hour = _currentTime.hour.toString().padLeft(2, '0');
      String minute = _currentTime.minute.toString().padLeft(2, '0');
      // String second = _currentTime.second.toString().padLeft(2, '0');

      return '$hour:$minute'; //:$second
    } else {
      return 'Loading...';
    }
  }

  String get periodOfDay {
    String hourOfDay = _currentTime.hour.toString().split(':')[0];

    switch (int.parse(hourOfDay)) {
      case < 12 && >= 0:      // 00:00 am - 11:59 am
        return 'Morning';
      case == 12:             // 12:00 pm - 12:59 pm
        return 'Noon';
      case < 16 && > 12:      // 13:00 pm - 15:59 pm
        return 'Afternoon';
      case >= 16 && <= 19:    // 16:00 pm - 19:59 pm
        return 'Evening';
      default:                // 20:00 pm - 23:59 pm
        return 'Night';
    }
  }

}
