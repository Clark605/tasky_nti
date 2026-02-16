import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_nti/core/firebase/fb_result.dart';
import 'package:tasky_nti/feature/auth/data/model/user_model.dart';
import 'package:tasky_nti/feature/home/data/model/task_model.dart';

abstract class FbTask {
  static CollectionReference<TaskModel> get _getCollection {
    final user = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .doc(user)
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        );
  }

  static Future<FbResult<void>> addTask(TaskModel task) async {
    try {
      task.id = _getCollection.doc().id;
      await _getCollection.doc(task.id).set(task);
      return Success();
    } catch (e) {
      return Failure(errorMsg: e.toString());
    }
  }

  static Future<FbResult<List<TaskModel>>> getUncompletedTasksOnDate(
    DateTime date,
  ) async {
    try {
      final formattedDate = DateTime(date.year, date.month, date.day);
      final querySnapshot = await _getCollection
          .where('isCompleted', isEqualTo: false)
          .where('dueDate', isEqualTo: formattedDate.millisecondsSinceEpoch)
          .orderBy('priority')
          .get();
      final tasks = querySnapshot.docs.map((doc) => doc.data()).toList();
      return Success(data: tasks);
    } catch (e) {
      return Failure(errorMsg: e.toString());
    }
  }

  static Future<FbResult<List<TaskModel>>> getCompletedTasksOnDate(
    DateTime date,
  ) async {
    try {
      final formattedDate = DateTime(date.year, date.month, date.day);

      final querySnapshot = await _getCollection
          .where('isCompleted', isEqualTo: true)
          .where('dueDate', isEqualTo: formattedDate.millisecondsSinceEpoch)
          .orderBy('priority')
          .get();
      final tasks = querySnapshot.docs.map((doc) => doc.data()).toList();

      return Success(data: tasks);
    } catch (e) {
      return Failure(errorMsg: e.toString());
    }
  }

  static Future<FbResult<void>> updateTask(TaskModel task) async {
    try {
      await _getCollection.doc(task.id).set(task);
      return Success();
    } catch (e) {
      return Failure(errorMsg: e.toString());
    }
  }

  static Future<FbResult<void>> deleteTask(String taskId) async {
    try {
      await _getCollection.doc(taskId).delete();
      return Success();
    } catch (e) {
      return Failure(errorMsg: e.toString());
    }
  }
}
