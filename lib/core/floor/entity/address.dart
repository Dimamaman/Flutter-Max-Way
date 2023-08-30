
import 'package:floor/floor.dart';

@Entity(tableName: "address")
class Address {
  @PrimaryKey(autoGenerate: false)
  final double lat;
  final double long;
  final String locationName;
  final String entrance;
  final String floor;
  final String flat;
  final String addressName;

  Address({required this.lat,required this.long,required this.locationName,required this.entrance, required this.floor,required this.flat,required this.addressName});

}