// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:megas_chat/models/User_Notifier.dart';
// import 'package:megas_chat/models/user_state.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AuthMethods {
//   static final Firestore _firestore = Firestore.instance;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   GoogleSignIn _googleSignIn = GoogleSignIn();
//   static final Firestore firestore = Firestore.instance;
//
//   static final CollectionReference _userCollection =
//       _firestore.collection(USERS_COLLECTION);
//
//   Future<FirebaseUser> getCurrentUser() async {
//     FirebaseUser currentUser;
//     currentUser = _auth.currentUser() as FirebaseUser;
//     return currentUser;
//   }
//
//   Future<MegaUser> getUserDetails() async {
//     FirebaseUser currentUser = await getCurrentUser();
//
//     DocumentSnapshot documentSnapshot =
//         await _userCollection.document(currentUser.uid).get();
//     return MegaUser.fromMap(documentSnapshot.data);
//   }
//
//   Future<MegaUser> getUserDetailsById(id) async {
//     try {
//       DocumentSnapshot documentSnapshot =
//           await _userCollection.document(id).get();
//       return MegaUser.fromMap(documentSnapshot.data);
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//   // ignore: missing_return
//   Future<FirebaseUser> signIn() async {
//     try {
//       GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
//       GoogleSignInAuthentication _signInAuthentication =
//           await _signInAccount.authentication;
//     } catch (e) {
//       print("Auth methods error");
//       print(e);
//       return null;
//     }
//   }
//
//   Future<bool> authenticateUser(FirebaseUser user) async {
//     QuerySnapshot result = await firestore
//         .collection(USERS_COLLECTION)
//         .where(EMAIL_FIELD, isEqualTo: user.email)
//         .getDocuments();
//
//     final List<DocumentSnapshot> docs = result.documents;
//
//     //////if user is registered then length of list > 0 or else less than 0
//     return docs.length == 0 ? true : false;
//   }
//
//   Future<void> addDataToDb(FirebaseUser currentUser) async {
//     String username = Utils.getUsername(currentUser.email);
//
//     MegaUser user = MegaUser(
//         id: currentUser.uid,
//         email: currentUser.email,
//         name: currentUser.displayName,
//         profilePhoto: currentUser.photoUrl,
//         username: username);
//
//     firestore
//         .collection(USERS_COLLECTION)
//         .document(currentUser.uid)
//         .setData(user.toMap(user));
//   }
//
//   Future<List<MegaUser>> fetchAllUsers(FirebaseUser currentUser) async {
//     List<MegaUser> userList = List<MegaUser>();
//
//     QuerySnapshot querySnapshot =
//         await firestore.collection(USERS_COLLECTION).getDocuments();
//     for (var i = 0; i < querySnapshot.documents.length; i++) {
//       if (querySnapshot.documents[i].documentID != currentUser.uid) {
//         userList.add(MegaUser.fromMap(querySnapshot.documents[i].data));
//       }
//     }
//     return userList;
//   }
//
//   Future<bool> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       await _auth.signOut();
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//   void setUserState({@required String userId, @required UserState userState}) {
//     int stateNum = Utils.stateToNum(userState);
//
//     _userCollection.document(userId).updateData({
//       "state": stateNum,
//     });
//   }
//
//   Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
//       _userCollection.document(uid).snapshots;
// }
