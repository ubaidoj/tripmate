class Booking {
  final String hotelName;
  final String roomType;
  final double price;
  final String userMessage;
  String status;
  String? response;

  Booking({
    required this.hotelName,
    required this.roomType,
    required this.price,
    required this.userMessage,
    this.status = 'Pending',
    this.response,
  });
}
