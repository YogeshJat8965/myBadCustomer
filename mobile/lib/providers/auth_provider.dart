import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/api/auth_api.dart';
import '../services/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class AuthProvider extends ChangeNotifier {
  final AuthApi _authApi = AuthApi();
  
  UserModel? _user;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    _setLoading(true);
    try {
      final response = await _authApi.register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
      );

      if (response.success && response.data != null) {
        await _handleAuthSuccess(response.data!);
        return true;
      } else {
        _error = response.message ?? 'Registration failed';
        return false;
      }
    } catch (e) {
      _error = _handleError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login(String emailOrPhone, String password) async {
    _setLoading(true);
    try {
      final response = await _authApi.login(
        emailOrPhone: emailOrPhone,
        password: password,
      );

      if (response.success && response.data != null) {
        await _handleAuthSuccess(response.data!);
        return true;
      } else {
        _error = response.message ?? 'Login failed';
        return false;
      }
    } catch (e) {
      _error = _handleError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authApi.logout();
    } catch (e) {
      // We still clear local state even if server logout fails
      debugPrint('Server logout failed: $e');
    } finally {
      await SecureStorage.deleteAll();
      _user = null;
      _isAuthenticated = false;
      _setLoading(false);
    }
  }

  Future<bool> checkAuthStatus() async {
    final token = await SecureStorage.getAccessToken();
    if (token == null) {
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }

    try {
      final response = await _authApi.getProfile();
      if (response.success && response.data != null) {
        _user = UserModel.fromJson(response.data!);
        _isAuthenticated = true;
        notifyListeners();
        return true;
      } else {
        await logout();
        return false;
      }
    } catch (e) {
      // API client interceptor will handle token refresh if 401
      // If still fails, interceptor should clear tokens and trigger logout
      await logout();
      return false;
    }
  }

  Future<void> _handleAuthSuccess(Map<String, dynamic> data) async {
    final accessToken = data['accessToken'] as String?;
    final refreshToken = data['refreshToken'] as String?;
    final userData = data['user'] as Map<String, dynamic>?;

    if (accessToken != null && refreshToken != null) {
      await SecureStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }

    if (userData != null) {
      _user = UserModel.fromJson(userData);
      _isAuthenticated = true;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _handleError(dynamic error) {
    if (error is DioException) {
      return error.response?.data?['message'] ?? 'Network error occurred';
    }
    return error.toString();
  }
}
