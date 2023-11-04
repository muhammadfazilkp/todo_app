import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late bool taskCompleted;

  @HiveField(3)
  int? key;

  Note(
      {required this.title, required this.content, this.taskCompleted = false,this.key});
}