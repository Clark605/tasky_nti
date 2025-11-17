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

  static Future<FbResult<List<TaskModel>>> getTasks() async {
    try {
      final querySnapshot = await _getCollection.get();
      final tasks = querySnapshot.docs.map((doc) => doc.data()).toList();
      return Success(data: tasks);
    } catch (e) {
      return Failure(errorMsg: e.toString());
    }
  }
}
