
class Branch {
  String id;
  String name;
  String phone;
  bool isActive;
  String address;
  String destination;
  Location location;
  String workHourStart;
  String workHourEnd;

  Branch._({
    required this.id,
    required this.name,
    required this.phone,
    required this.isActive,
    required this.address,
    required this.destination,
    required this.location,
    required this.workHourStart,
    required this.workHourEnd,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch._(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      isActive: json['is_active'] ?? '',
      address: json['address'] ?? '',
      destination: json['destination'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      workHourStart: json['work_hour_start'] ?? '',
      workHourEnd: json['work_hour_end'] ?? '',
    );
  }

}

class Location {
  double long;
  double lat;

  Location._({
    required this.long,
    required this.lat,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location._(
        long: json['long'] ?? '',
        lat: json['lat'] ?? '',
    );
  }

}
