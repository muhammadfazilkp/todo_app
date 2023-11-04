import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/model/model.dart';

class CrudOpretion extends ChangeNotifier {
  static const String todoApp = 'notes';

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  TextEditingController editTitleController = TextEditingController();
  TextEditingController editContentController = TextEditingController();

  // void edit(String head, String body) {
  //   editTitleController.text = head;
  //   editContentController.text = body;
  //   notifyListeners();
  // }

  Future<Box<Note>> openBox() async {
    return await Hive.box<Note>(todoApp);
  }

  Future<void> addNote(Note note) async {
    final box = await openBox();
    int key = await box.add(note);
    note.key = key;
    box.put(key, note);
    notifyListeners();
  }

  Future<void> deleteNote(int index) async {
    final box = await openBox();
    await box.deleteAt(index);
    notifyListeners();
  }

  Future<List<Note>> getNotes() async {
    final box = await openBox();
    return box.values.toList();
  }
 void updateTaskCompletion(int index, bool taskCompleted) async {
    final box = await openBox();
    Note? note = box.getAt(index);

    if (note != null) {
      note.taskCompleted = taskCompleted;
      await box.putAt(index, note);
      notifyListeners();
    }
  }
void toggleTaskCompletion(int index, bool newCompletionStatus) async {
  final box = await openBox();
  Note? note = box.getAt(index);

  if (note != null) {
    note.taskCompleted = newCompletionStatus;
    await box.putAt(index, note);
    notifyListeners();
  }
}


}
