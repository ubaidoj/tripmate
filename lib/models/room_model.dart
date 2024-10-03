class Room {
  final String type;
  final double price;
  final String description;

  Room({required this.type, required this.price, required this.description});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      type: json['type'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }
}
