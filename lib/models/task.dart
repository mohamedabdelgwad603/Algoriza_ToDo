import 'dart:convert';

class TaskModel {
  List<Task>? tasks = [];
  TaskModel.fromMap(List<Map<String, dynamic>>? json) {
    if (json != null) {
      json.forEach((element) {
        tasks?.add(Task.fromMap(element));
      });
    }
  }
}

class Task {
  int? id;
  String? title;
  int? isCompleted;
  int? isFavourite;
  String? isCompletedDate;
  String? date;
  String? startTime;
  String? endTime;
  String? color;
  int? remind;
  String? repeat;
  Task(
      {this.id,
      this.title,
      this.isCompleted,
      this.isFavourite,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.remind,
      this.repeat,
      this.isCompletedDate});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (isCompleted != null) {
      result.addAll({'isCompleted': isCompleted});
    }
    if (isFavourite != null) {
      result.addAll({'isFavourite': isFavourite});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (isCompletedDate != null) {
      result.addAll({'isCompletedDate': isCompletedDate});
    }
    if (startTime != null) {
      result.addAll({'startTime': startTime});
    }
    if (endTime != null) {
      result.addAll({'endTime': endTime});
    }
    if (color != null) {
      result.addAll({'color': color});
    }
    if (remind != null) {
      result.addAll({'remind': remind});
    }
    if (repeat != null) {
      result.addAll({'repeat': repeat});
    }

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt(),
      title: map['title'],
      isCompleted: map['isCompleted']?.toInt(),
      isFavourite: map['isFavourite']?.toInt(),
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      color: map['color'],
      remind: map['remind']?.toInt(),
      repeat: map['repeat'],
      isCompletedDate: map['isCompletedDate'],
    );
  }
}
