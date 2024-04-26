import 'package:flutter/material.dart';

class Task {
  final String title;
  final String description;
  final int status;
  final int priority;
  final Color color;
  final DateTime date;

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.color,
    required this.date,
  });
}
