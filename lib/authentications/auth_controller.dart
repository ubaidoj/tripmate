// File: controller/auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var userName = ''.obs;
  var profileImageUrl = ''.obs;

  firebase_auth.User? get currentUser => _firebaseAuth.currentUser;

  Stream<firebase_auth.User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _loadProfileImage();
  }

  Future<void> _loadUserData() async {
    final user = currentUser;
    if (user != null) {
      final userData = await _firestore.collection('users').doc(user.uid).get();
      if (userData.exists) {
        userName.value = userData['name'] ?? 'User';
      }
    }
  }

  Future<void> saveProfileImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImageUrl', imagePath);
    profileImageUrl.value = imagePath;
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profileImageUrl.value = prefs.getString('profileImageUrl') ?? '';
  }

  Future<String?> signUp(String email, String password, String name, {String? phoneNumber, String? birthDate}) async {
    try {
      isLoading.value = true;
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'name': name,
          'phoneNumber': phoneNumber ?? '',
          'birthDate': birthDate ?? '',
          'profileImageUrl': '',
        });
        await _loadUserData();
        isLoading.value = false;
        return null;
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      isLoading.value = false;
      return e.message;
    }
    isLoading.value = false;
    return 'Sign-up failed';
  }

  Future<String?> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await _loadUserData();
      isLoading.value = false;
      return null;
    } on firebase_auth.FirebaseAuthException catch (e) {
      isLoading.value = false;
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    userName.value = '';
    profileImageUrl.value = '';
  }
}
