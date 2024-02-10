import 'package:flutter/material.dart';
import 'package:todo/event_list/repo/event_interface.dart';
import '../models/event_model.dart';

class SaveEvent extends ChangeNotifier {
  IEventRepository eventRepository;

  late String _title;
  late String _start;
  late String _end;
  late String _category;
  String? _note;
  String? _reminder;
  String? _location;
  String? _priority;

  String _saveStatus = 'Not Saved';

  SaveEvent(this.eventRepository);

  // getters
  String get saveStatus => _saveStatus;

  // setters
  void changeTitle(String title) {
    _title = title;
  }

  void changeStart(String start) {
    _start = start;
  }

  void changeEnd(String end) {
    _end = end;
  }

  void changeCategory(String category) {
    _category = category;
  }

  void changeNote(String note) {
    _note = note;
  }

  void saveEvent() async {
    _saveStatus = 'Saving';
    try {
      Event event = Event(title: _title, start: _start, end: _end, category: _category);
      int res = await eventRepository.insert(event);
      res is int ? _saveStatus = 'Saved' : _saveStatus = 'Not Saved';
    } catch (e) {
      print(e);
      _saveStatus = 'Not Saved';
    }
    notifyListeners();
  }
}