import 'dart:async';
import 'package:flutter/material.dart';

class TaskStatus {
  final String id;
  final String title;
  final String status;
  final String time;

  TaskStatus({required this.id, required this.title, required this.status, required this.time});
}

class AlertStatus {
  final String id;
  final String message;
  final String location;
  final bool isCritical;

  AlertStatus({required this.id, required this.message, required this.location, required this.isCritical});
}

class DataProvider with ChangeNotifier {
  final _taskController = StreamController<List<TaskStatus>>.broadcast();
  final _alertController = StreamController<List<AlertStatus>>.broadcast();

  Stream<List<TaskStatus>> get taskStream => _taskController.stream;
  Stream<List<AlertStatus>> get alertStream => _alertController.stream;

  DataProvider() {
    _initSimulatedStreams();
  }

  void _initSimulatedStreams() {
    // Simulate real-time updates from Firestore
    Timer.periodic(const Duration(seconds: 10), (timer) {
      _taskController.add([
        TaskStatus(id: '1', title: 'Room 101 cleaning', status: 'In Progress', time: '5m ago'),
        TaskStatus(id: '2', title: 'Mini-bar restock R302', status: 'Pending', time: '12m ago'),
        if (timer.tick % 2 == 0)
          TaskStatus(id: '3', title: 'AC Repair R205', status: 'Urgent', time: 'Just now'),
      ]);

      _alertController.add([
        AlertStatus(id: 'a1', message: 'Main Gate Access', location: 'Gate A', isCritical: false),
        if (timer.tick % 3 == 0)
          AlertStatus(id: 'a2', message: 'Smoke Detector Active', location: 'Floor 3', isCritical: true),
      ]);
    });
  }

  @override
  void dispose() {
    _taskController.close();
    _alertController.close();
    super.dispose();
  }
}
