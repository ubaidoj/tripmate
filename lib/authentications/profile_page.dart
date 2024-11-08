// File: pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmate/authentications/auth_controller.dart';
import 'package:tripmate/authentications/signin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController authController = Get.find<AuthController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? name;
  String? email;
  String? profileImageUrl;
  String? phoneNumber;
  String? birthDate;
  bool isLoading = true;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          setState(() {
            name = doc['name'];
            email = doc['email'];
            phoneNumber = doc['phoneNumber'];
            birthDate = doc['birthDate'];
            profileImageUrl = authController.profileImageUrl.value;

            _nameController.text = name ?? '';
            _phoneController.text = phoneNumber ?? '';
            _birthDateController.text = birthDate ?? '';
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          Get.snackbar('Error', 'User data not found');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        Get.snackbar('Error', 'Failed to load user data');
      }
    }
  }

  Future<void> _updateProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': _nameController.text,
        'phoneNumber': _phoneController.text,
        'birthDate': _birthDateController.text,
      });
      Get.snackbar('Success', 'Profile updated successfully');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      authController.saveProfileImage(pickedFile.path);
      setState(() {
        profileImageUrl = pickedFile.path;
      });
    }
  }

  Future<void> _logout() async {
    await authController.signOut();
    Get.offAll(() => SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 96, 132),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: profileImageUrl != null
                          ? FileImage(File(profileImageUrl!))
                          : const AssetImage('assets/default_profile.png') as ImageProvider,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.camera_alt, color: Color.fromRGBO(22, 86, 182, 1), size: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone number'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _birthDateController,
                    decoration: const InputDecoration(labelText: 'Date of Birth'),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        _birthDateController.text =
                            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                      }
                    },
                    readOnly: true,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                    child: const Text('Save Changes', style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _logout,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(22, 86, 182, 1),),
                    child: const Text('Log out',  style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
    );
  }
}
