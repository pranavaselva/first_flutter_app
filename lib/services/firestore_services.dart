import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  // Create: Add a new task for a specific user
  Future<void> addTask(String userId, String taskTitle) {
    return tasks.add({
      'userId': userId,
      'title': taskTitle,
      'isCompleted': false,
      'createdAt': Timestamp.now(),
    });
  }

  // Read: Get real-time stream of tasks for the logged-in user
  Stream<QuerySnapshot> getTasks(String userId) {
    return tasks
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Update: Toggle completion
  Future<void> toggleTask(String docId, bool status) {
    return tasks.doc(docId).update({'isCompleted': status});
  }

  // Delete
  Future<void> deleteTask(String docId) {
    return tasks.doc(docId).delete();
  }
}