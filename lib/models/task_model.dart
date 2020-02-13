import 'package:flutter/foundation.dart';

class Task {
  int id;
  String name;

  Task({
    this.id,
    @required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
