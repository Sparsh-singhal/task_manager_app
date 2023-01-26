class Task {
  String title;
  DateTime date;
  String priority;

  Task({
    this.title = "Please enter the title",
    required this.date,
    this.priority = "high",
  });
}
