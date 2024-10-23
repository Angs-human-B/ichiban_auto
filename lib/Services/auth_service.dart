import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/userModel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return UserModel.fromMap(userDoc.data()!);
        }
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> saveUserToFirestore(UserModel userModel) async {
    await _firestore.collection('users').doc(userModel.uid).set(userModel.toMap());
  }

  Future<UserModel?> signUp({required String name, required String phone, required String email, required String password, required String role}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        phone: phone,
        email: email,
        role: role,
      );

      // Save user to Firestore
      await _firestore.collection('users').doc(user.uid).set(user.toMap());

      // Save user locally
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('user', user.toMap().toString());

      return user;
    } catch (e) {
      print('Error during sign up: $e');
      return null;
    }
  }
  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
