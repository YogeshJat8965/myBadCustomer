import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme/app_theme.dart';
import 'config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp() — Phase 7 mein enable karenge
  
  runApp(
    MultiProvider(
      providers: [
        // Placeholder for AuthProvider until it's created
        Provider(create: (_) => 'AuthProvider_Placeholder'),
      ],
      child: const MyBadCustomerApp(),
    ),
  );
}

class MyBadCustomerApp extends StatelessWidget {
  const MyBadCustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Bad Customer',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
