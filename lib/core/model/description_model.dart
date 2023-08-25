import 'package:hive/hive.dart';
part 'description_model.g.dart';

@HiveType(typeId: 1)
class DescriptionData {
  @HiveField(0)
  String uz;

  DescriptionData({
    required this.uz,
  });

  factory DescriptionData.fromJson(Map<String,dynamic> json) {
    return DescriptionData(
      uz: json['uz'] ?? '',
    );
  }
}