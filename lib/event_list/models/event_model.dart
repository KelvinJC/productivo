class Event {
  final String title;
  final String start;
  final String end;
  final String category;
  String? note;
  String? reminder;
  String? location;
  String? priority;

  Event({
    required this.title,
    required this.start,
    required this.end,
    required this.category,
  });

  // Convert an event into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'start': start,
      'end': end,
      'category': category,
      'note': note,
      'reminder': reminder,
      'location': location,
      'priority': priority
    };
  }

  // Implement toString to make it easier to see information about
  // each event when using the print statement.
  @override
  String toString() {
    return 'Event{title: $title, start: $start, end: $end, category: $category}';
  }
}