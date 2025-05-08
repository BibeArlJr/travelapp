import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart'; // ✅ import added

// Firebase core
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Your providers
import 'providers/auth_provider.dart';
import 'providers/place_provider.dart';

// Your screens
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/home_page.dart';
import 'screens/list_page.dart';
import 'screens/details_page.dart';
import 'screens/cart_page.dart';
import 'screens/profile_page.dart';
import 'screens/admin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    DevicePreview(
      enabled: true, // You can toggle this for release mode
      builder:
          (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => PlaceProvider()),
            ],
            child: const TravelApp(),
          ),
    ),
  );
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true, // ✅ required for device_preview
      locale: DevicePreview.locale(context), // ✅
      builder: DevicePreview.appBuilder, // ✅

      title: 'Wonderful United Kingdom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF2F2F2),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignupPage(),
        '/home': (_) => const HomePage(),
        '/list': (_) => const ListPage(),
        '/detail': (_) => const DetailsPage(),
        '/cart': (_) => const CartPage(),
        '/profile': (_) => const ProfilePage(),
        '/admin': (_) => const AdminPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const LoginPage());
      },
    );
  }
}
