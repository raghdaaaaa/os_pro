import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String?  id;
  final String   userId;
  final String   title;
  final String   description;
  final String   priority;     // 'high' | 'medium' | 'low'
  final DateTime dueDate;
  final String   startTime;
  final String   endTime;
  final bool     isCompleted;
  final int      points;

  TaskModel({
    this.id,
    required this.userId,
    required this.title,
    this.description = '',
    this.priority    = 'medium',
    required this.dueDate,
    this.startTime   = '',
    this.endTime     = '',
    this.isCompleted = false,
    this.points      = 10,
  });

  // Firestore doc → TaskModel
  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id:          doc.id,
      userId:      d['userId']      ?? '',
      title:       d['title']       ?? '',
      description: d['description'] ?? '',
      priority:    d['priority']    ?? 'medium',
      dueDate:     (d['dueDate'] as Timestamp).toDate(),
      startTime:   d['startTime']   ?? '',
      endTime:     d['endTime']     ?? '',
      isCompleted: d['isCompleted'] ?? false,
      points:      d['points']      ?? 10,
    );
  }

  // TaskModel → Map to save in Firestore
  Map<String, dynamic> toMap() => {
    'userId':      userId,
    'title':       title,
    'description': description,
    'priority':    priority,
    'dueDate':     Timestamp.fromDate(dueDate),
    'startTime':   startTime,
    'endTime':     endTime,
    'isCompleted': isCompleted,
    'points':      points,
    'createdAt':   FieldValue.serverTimestamp(),
  };
}
