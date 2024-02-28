import 'dart:async';

import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/signin_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Toddle {
  FirebaseAuth auth = FirebaseAuth.instance;
  userstatus(BuildContext context) {
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignInView()));
      });
    }
  }
}
