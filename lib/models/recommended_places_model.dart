class RecommendedPlaceModel {
  final String name;
  final String image;
  final String city;
  final double lat;
  final double long;

  RecommendedPlaceModel({
    required this.name,
    required this.image,
    required this.city,
    required this.lat,
    required this.long,
  });

  factory RecommendedPlaceModel.fromJson(Map<String, dynamic> json, String city) {
    return RecommendedPlaceModel(
      name: json['name'],
      image: json['image'],
      city: city,
      lat: json['lat'],
      long: json['long'],
    );
  }
}
