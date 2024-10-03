import 'room_model.dart';

class Hotel {
  final String name;
  final String image;
  final String location;
  final String contact;
  final List<Room> rooms;
  double? rating;  

  Hotel({
    required this.name,
    required this.image,
    required this.location,
    required this.contact,
    required this.rooms,
    this.rating,  
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    var roomList = json['rooms'] as List;
    List<Room> rooms = roomList.map((roomJson) => Room.fromJson(roomJson)).toList();

    return Hotel(
      name: json['name'],
      image: json['image'],
      location: json['location'],
      contact: json['contact'],
      rooms: rooms,
      rating: json['rating']?.toDouble() ?? 0.0,  // Parse rating from JSON or default to 0
    );
  }
}
