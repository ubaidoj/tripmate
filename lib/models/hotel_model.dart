import 'room_model.dart';

class Hotel {
  final String name;
  final String image;
  final String location;
  final String contact;
  final List<Room> rooms;
  final double rating;  // Changed to 'final' to ensure rating is not null.

  Hotel({
    required this.name,
    required this.image,
    required this.location,
    required this.contact,
    required this.rooms,
    this.rating = 0.0,  // Default value for rating is 0.0 if not provided.
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    // Handle the 'rooms' list with a null check and map it to the Room model.
    var roomList = json['rooms'] as List? ?? [];  // Handle null or empty lists.
    List<Room> rooms = roomList.map((roomJson) => Room.fromJson(roomJson)).toList();

    return Hotel(
      name: json['name'] ?? '',  // Handle potential null name by defaulting to an empty string.
      image: json['image'] ?? '',  // Handle potential null image.
      location: json['location'] ?? '',  // Handle potential null location.
      contact: json['contact'] ?? '',  // Handle potential null contact.
      rooms: rooms,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,  // Ensure rating is a double, defaulting to 0.0.
    );
  }
}
