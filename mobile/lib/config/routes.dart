import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/storage/secure_storage.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      // Basic redirect logic based on token presence
      // A more robust solution will use AuthProvider's state in the future
      final hasToken = await SecureStorage.getAccessToken() != null;
      
      final isGoingToAuth = state.matchedLocation == '/welcome' || 
                            state.matchedLocation == '/login' || 
                            state.matchedLocation == '/register';

      if (!hasToken && !isGoingToAuth && state.matchedLocation != '/splash') {
        return '/welcome';
      }

      // If user has token and tries to go to auth screens, redirect to home
      if (hasToken && isGoingToAuth) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Splash Screen'))),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Welcome Screen'))),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Login Screen'))),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Register Screen'))),
      ),
      GoRoute(
        path: '/verification-pending',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Verification Pending'))),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Home Screen'))),
      ),
      GoRoute(
        path: '/business/register',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Business Register'))),
      ),
      GoRoute(
        path: '/business/profile',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Business Profile'))),
      ),
      GoRoute(
        path: '/customer/search',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Customer Search'))),
      ),
      GoRoute(
        path: '/customer/:id',
        builder: (context, state) => Scaffold(body: Center(child: Text('Customer ${state.pathParameters['id']}'))),
      ),
      GoRoute(
        path: '/report/create',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Report Create'))),
      ),
      GoRoute(
        path: '/report/my-reports',
        builder: (context, state) => const Scaffold(body: Center(child: Text('My Reports'))),
      ),
      GoRoute(
        path: '/report/:id',
        builder: (context, state) => Scaffold(body: Center(child: Text('Report ${state.pathParameters['id']}'))),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Notifications'))),
      ),
    ],
  );
}
