

class Event {
  int? id;
  final String title;
  final String start;
  final String end;
  final String category;
  String? note;
  String? reminder;
  String? location;
  String? priority;

  Event({
    this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.category,
    this.note,
    this.reminder,
    this.location,
    this.priority,
  });

  // Convert an event into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
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

  Event.fromMap(Map<String, dynamic> data) :
    id = data['id'],
    title = data['title'],
    start = data['start'],
    end = data['end'],
    category = data['category'],
    note = data['note'],
    reminder = data['reminder'],
    location = data['location'],
    priority = data['priority'];


  // Implement toString to make it easier to see information about
  // each event when using the print statement.
  @override
  String toString() {
    return 'Event{id: $id, title: $title, start: $start, end: $end, category: $category}';
  }
}