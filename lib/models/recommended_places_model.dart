class RecommendedPlaceModel {
  final String image;
  final double rating; // You can assign a default rating as the JSON doesn't contain ratings
  final String location;

  RecommendedPlaceModel({
    required this.image,
    required this.rating,
    required this.location,
  });

  factory RecommendedPlaceModel.fromJson(Map<String, dynamic> json) {
    // Assuming the first image from the gallery in tour_places is being used
    return RecommendedPlaceModel(
      image: json['tour_places'][0]['image'], // Accessing image from tour_places array
      rating: 4.5, // Default rating if not available in JSON
      location: json['location'],
    );
  }
}
