import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripmate/authentications/profile_page.dart';
import 'package:tripmate/authentications/signin_page.dart';

class AuthController extends GetxController {
  // Rx variables for state management
  var profileImage = Rx<File?>(null);

  // Text controllers for form fields
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  // Firebase user
  User? user = FirebaseAuth.instance.currentUser;

  // Method to pick an image using ImagePicker
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  // Signup function
  Future<void> signup() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // Storing user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
          'firstName': firstNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'email': emailController.text.trim(),
        });
        Get.off(ProfilePage()); // Navigate to ProfilePage
      } else {
        Get.snackbar('Error', 'Passwords do not match');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Google Sign-In function
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.off(ProfilePage());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Login function
  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.off(ProfilePage());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Forgot password function
  Future<void> forgotPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Get.snackbar('Success', 'Password reset email sent');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Logout function
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.off(SigninPage());
  }

  // Update profile function
  Future<void> updateProfile() async {
    try {
      user?.updateDisplayName(firstNameController.text.trim());
      user?.updatePhotoURL(profileImage.value?.path);
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
      });
      Get.snackbar('Success', 'Profile updated');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
