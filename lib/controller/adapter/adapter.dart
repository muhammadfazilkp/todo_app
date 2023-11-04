import 'package:hive/hive.dart';
import 'package:todo_app/model/model.dart';

class CustomNoteAdapter extends TypeAdapter<Note> {
  @override
  int get typeId => 0;

  @override
  Note read(BinaryReader reader) {
    try {
      final title = reader.readString();
      final content = reader.readString();
      return Note(title: title, content: content);
    } catch (e) {
      print('Error reading note: $e');
      return Note(title: '', content: '');
    }
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    try {
      writer.writeString(obj.title);
      writer.writeString(obj.content);
    } catch (e) {
      print('Error writing note: $e');
    }
  }
}