import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterparcial4venturabonilla/mantenimientos/clientes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseAPP());
}

class FirebaseAPP extends StatelessWidget {
  const FirebaseAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parcial N4 Ventura y Bonilla',
      home: Clientes(),
    );
  }
}
