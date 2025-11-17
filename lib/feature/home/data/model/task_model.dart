import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? description;
  DateTime? date;
  int? priority;
  bool? isCompleted;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.priority,
    this.isCompleted = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'])
          : null,
      priority: map['priority'],
      isCompleted: map['isCompleted'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': date?.millisecondsSinceEpoch,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  void setDate(DateTime date) {
    this.date = date;
    notifyListeners();
  }

  void setPriority(int priority) {
    this.priority = priority;
    notifyListeners();
  }
}
