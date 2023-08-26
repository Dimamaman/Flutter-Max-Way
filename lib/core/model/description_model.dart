import 'package:hive/hive.dart';


class DescriptionData {
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