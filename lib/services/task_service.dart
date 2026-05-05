import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brain_stack/models/task_model.dart';

class TaskService {
  final _tasks = FirebaseFirestore.instance.collection('tasks');

  // Add new task → returns new document ID
  Future<String> addTask(TaskModel task) async {
    final ref = await _tasks.add(task.toMap());
    return ref.id;
  }

  // Live stream of all tasks for a user (auto-updates UI)
  Stream<List<TaskModel>> getTasks(String userId) {
    return _tasks
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(TaskModel.fromFirestore).toList());
  }

  // Update specific fields on a task
  Future<void> updateTask(String taskId, Map<String, dynamic> fields) {
    return _tasks.doc(taskId).update(fields);
  }

  // Delete a task permanently
  Future<void> deleteTask(String taskId) {
    return _tasks.doc(taskId).delete();
  }

  // Mark task as done
  Future<void> completeTask(String taskId) {
    return _tasks.doc(taskId).update({'isCompleted': true});
  }
}
