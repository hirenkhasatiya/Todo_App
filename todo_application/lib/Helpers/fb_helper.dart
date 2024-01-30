import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_application/Modals/todo_modal.dart';

class FbHelper {
  FbHelper._();

  static final FbHelper fbHelper = FbHelper._();

  String collectionPath = "To-Do";

  bool check = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getToDo() {
    return firestore.collection(collectionPath).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getdoneToDo() {
    return firestore
        .collection(collectionPath)
        .doc("task-done")
        .collection("all-done-task")
        .snapshots();
  }

  doneToDo({required TaskModal task}) {
    firestore
        .collection(collectionPath)
        .doc("task-done")
        .collection("all-done-task")
        .doc(task.task)
        .set(task.toMap);
  }

  completToDo({required TaskModal task}) {
    firestore.collection(collectionPath).doc(task.task).update(task.toMap);
  }

  addToDo({required TaskModal task}) {
    firestore.collection(collectionPath).doc(task.task).set(task.toMap);
  }

  editToDo({required TaskModal task}) {
    firestore.collection(collectionPath).doc(task.task).update(task.toMap);
  }

  deletToDo({required TaskModal task}) {
    firestore.collection(collectionPath).doc(task.task).delete();
  }
}
