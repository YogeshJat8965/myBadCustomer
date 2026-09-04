import 'api_client.dart';
import 'api_endpoints.dart';
import '../../models/api_response_model.dart';

class AuthApi {
  final ApiClient _client = ApiClient();

  Future<ApiResponse> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    return await _client.post(ApiEndpoints.register, data: {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'confirmPassword': confirmPassword,
    });
  }

  Future<ApiResponse> login({
    required String emailOrPhone,
    required String password,
  }) async {
    return await _client.post(ApiEndpoints.login, data: {
      'emailOrPhone': emailOrPhone,
      'password': password,
    });
  }

  Future<ApiResponse> logout() async {
    return await _client.post(ApiEndpoints.logout);
  }

  Future<ApiResponse> getProfile() async {
    return await _client.get(ApiEndpoints.profile);
  }
}
