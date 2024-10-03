import 'package:get/get.dart';
import 'package:tripmate/models/recommended_places_model.dart';

class RecommendedPlacesController extends GetxController {
  var recommendedPlaces = <RecommendedPlaceModel>[].obs; // Observable list

  @override
  void onInit() {
    super.onInit();
    loadRecommendedPlaces();
  }

  void loadRecommendedPlaces() {
    // Load recommended places
    // For example, loading from an API or a local list
    recommendedPlaces.value = [
      RecommendedPlaceModel(
      
        image: "assets/images/bora_bora.jpg",
        rating: 4.4,
        location: "French Polynesia",
      ),
      // Add more places
    ];
  }
}
