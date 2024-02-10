import 'package:flutter/material.dart';
import 'package:todo/event_list/models/event_model.dart';
import '../../common/errors/error_status.dart';
import '../repo/event_interface.dart';

class DisplayEventsViewModel extends ChangeNotifier {
  final IEventRepository _eventRepository; // Liskov Substitution

  DisplayEventsViewModel(this._eventRepository);


  Future<List<Event>> getEventsMostRecentFirst() async {
    // when event data fetched successfully from db,
    // reverse it to show most recently created event first
    try {
      List<Event> events = await _eventRepository.getAll();
      return events.reversed.toList();
    } catch(e) {
      print(e);
      throw Failure(errorResponse: e.toString());    }
  }
}