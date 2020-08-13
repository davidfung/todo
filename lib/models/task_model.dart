import 'package:flutter/foundation.dart';

class Task {
  int id;
  String name;
  String timestamp;

  Task({
    this.id,
    @required this.name,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'timestamp': timestamp,
    };
  }
}
