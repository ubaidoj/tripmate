import 'package:flutter/material.dart';
import 'package:tripmate/Screens/googlemaps_screen.dart';
import 'package:tripmate/models/hotel_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class HotelDetailsPage extends StatefulWidget {
  final Hotel hotel;

  HotelDetailsPage({required this.hotel});

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // Scroll controller to scroll to the comment section

  // Separate ratings for each category
  double _staffRating = 0.0;
  double _roomsRating = 0.0;
  double _serviceRating = 0.0;
  double _priceRating = 0.0;
  double _cleanlinessRating = 0.0;

  bool _showCommentsSection = false; 

  // Function to launch a phone call
  _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // Function to submit the comment and multiple ratings
  void _submitFeedback() {
    if (_commentController.text.isNotEmpty &&
        _staffRating > 0 &&
        _roomsRating > 0 &&
        _serviceRating > 0 &&
        _priceRating > 0 &&
        _cleanlinessRating > 0) {
      // Handle the feedback submission logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback submitted:\n'
            'Staff Rating: $_staffRating\n'
            'Rooms Rating: $_roomsRating\n'
            'Service Rating: $_serviceRating\n'
            'Price Rating: $_priceRating\n'
            'Cleanliness Rating: $_cleanlinessRating\n'
            'Comment: ${_commentController.text}')),
      );

      // Clear input fields after submission
      _commentController.clear();
      setState(() {
        _staffRating = 0.0;
        _roomsRating = 0.0;
        _serviceRating = 0.0;
        _priceRating = 0.0;
        _cleanlinessRating = 0.0;
      });
    } else {
      // Show a message if either field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating and a comment for all categories')),
      );
    }
  }

  // Toggle the comment section visibility and scroll to the section
  void _toggleCommentsSection() {
    setState(() {
      _showCommentsSection = true;
    });

    // Scroll to the comment section after enabling it
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotel.name),
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Assign the scroll controller
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full-width hotel image
            Image.asset(
              widget.hotel.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            // Hotel Name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.hotel.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Comment Icon Below the Image
            Center(
              child: IconButton(
                icon: Icon(Icons.comment, size: 30),
                onPressed: _toggleCommentsSection, // Show the comments section and scroll to it when clicked
              ),
            ),
            SizedBox(height: 10),
            // Room Details (loaded from JSON)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Room Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.hotel.rooms.length,
              itemBuilder: (context, index) {
                final room = widget.hotel.rooms[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: ListTile(
                      title: Text(room.type, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(room.description),
                          SizedBox(height: 10),
                          Text('Price: \pkr${room.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Divider(),
            // Hotel Location
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () async {
                  // Check for location permission
                  LocationPermission permission = await Geolocator.checkPermission();
                  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
                    permission = await Geolocator.requestPermission();
                  }

                  if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
                    // Navigate to Google Maps screen with the hotel location
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenMap(
                          destinationLocation: widget.hotel.location, // Pass hotel location
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Location permission is required to access the map.')),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.hotel.location,
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            // Contact Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  _makePhoneCall(widget.hotel.contact); // Call phone number
                },
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 10),
                    Text(
                      widget.hotel.contact,
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),

            // Show Comments Section only when the comment icon is clicked
            if (_showCommentsSection)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display existing comments (dummy comments here)
                    Text(
                      'User Comments',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildCommentTile('Ubaid Ullah', 'Great hotel, loved the service!', 4.5),
                    _buildCommentTile('Muhammad Ahsan', 'Comfortable rooms and friendly staff.', 4.0),
                    Divider(),
                    SizedBox(height: 10),
                    // User Feedback Section (Rating & Comment)
                    Text(
                      'Leave a Rating & Comment',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    
                    // Staff Rating
                    _buildRatingRow('Staff', _staffRating, (value) {
                      setState(() {
                        _staffRating = value;
                      });
                    }),

                    // Rooms Rating
                    _buildRatingRow('Rooms', _roomsRating, (value) {
                      setState(() {
                        _roomsRating = value;
                      });
                    }),

                    // Service Rating
                    _buildRatingRow('Service', _serviceRating, (value) {
                      setState(() {
                        _serviceRating = value;
                      });
                    }),

                    // Price Rating
                    _buildRatingRow('Price', _priceRating, (value) {
                      setState(() {
                        _priceRating = value;
                      });
                    }),

                    // Cleanliness Rating
                    _buildRatingRow('Cleanliness', _cleanlinessRating, (value) {
                      setState(() {
                        _cleanlinessRating = value;
                      });
                    }),

                    SizedBox(height: 10),
                    // Comment Input
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your comment here',
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 10),
                    // Submit Button
                    ElevatedButton(
                      onPressed: _submitFeedback,
                      child: Text('Submit Feedback'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to build a tile for existing user comments
  Widget _buildCommentTile(String username, String comment, double rating) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.person)),
      title: Text(username),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment),
          SizedBox(height: 5),
          Text('Rating: ${rating.toStringAsFixed(1)} / 5'),
        ],
      ),
    );
  }

  // Helper function to create a rating slider for each category
  Widget _buildRatingRow(String label, double currentValue, Function(double) onChanged) {
    return Column(
      children: [
        Row(
          children: [
            Text('$label Rating: ', style: TextStyle(fontSize: 16)),
            Expanded(
              child: Slider(
                value: currentValue,
                min: 0,
                max: 5,
                divisions: 5,
                label: currentValue.toString(),
                onChanged: onChanged,
              ),
            ),
            Text('${currentValue.toStringAsFixed(1)} / 5'),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
