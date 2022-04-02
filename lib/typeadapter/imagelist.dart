import 'package:hive/hive.dart';
part 'imagelist.g.dart';

@HiveType(typeId: 0)
class imagehive extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? image;

  imagehive({this.id, this.image});
}
//flutter packages pub run build_runner build