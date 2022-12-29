class Task {
  String id;
  String tittle;
  String description;
  DateTime dateTime;
  bool isDone;

  Task(
      {this.id = '',
      required this.tittle,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            tittle: data['tittle'],
            description: data['description'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['datetime']),
            isDone: data['isDone']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'tittle': tittle,
      'description': description,
      'datetime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }
}
