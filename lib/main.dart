import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arduino/auth/domain/auth_scope_providers.dart';
import 'package:flutter_arduino/auth/presentation/screens/auth_screen.dart';
import 'package:flutter_arduino/devices/presentation/screens/devices_screen.dart';
import 'package:flutter_arduino/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Arduino',
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          final uid = ref.watch(userProvider)?.uid;
          if (uid != null) return const DevicesScreen();

          return const AuthScreen();
        },
      ),
    );
  }
}
