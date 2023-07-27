// import 'package:animation/app/dash_board.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthGate extends StatelessWidget {
//   final Widget child;
//   const AuthGate({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return const DashBoardScreen();
//           } else {
//             return PhoneVerificationScreen();
//           }
//         });
//   }
// }
