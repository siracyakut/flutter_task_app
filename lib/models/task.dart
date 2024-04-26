class Task {
  late String id;
  late String title;
  late String description;
  late int status;
  late int priority;
  late String color;
  late String date;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.color,
    required this.date,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    priority = json['priority'];
    color = json['color'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['priority'] = priority;
    data['color'] = color;
    data['date'] = date;
    return data;
  }
}
