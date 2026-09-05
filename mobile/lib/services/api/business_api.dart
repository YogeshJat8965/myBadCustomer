import 'dart:io';
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_endpoints.dart';
import '../../models/api_response_model.dart';

class BusinessApi {
  final ApiClient _client = ApiClient();

  Future<ApiResponse> registerBusiness(Map<String, dynamic> data, File? proofFile) async {
    try {
      FormData formData = FormData.fromMap(data);
      if (proofFile != null) {
        formData.files.add(MapEntry(
          'proof',
          await MultipartFile.fromFile(
            proofFile.path,
            filename: proofFile.path.split('/').last,
          ),
        ));
      }

      final response = await _client.dio.post(
        ApiEndpoints.businessRegister,
        data: formData,
      );

      return ApiResponse.fromJson(response.data, (json) => json);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> getMyBusiness() async {
    try {
      final response = await _client.dio.get(ApiEndpoints.businessProfile);
      return ApiResponse.fromJson(response.data, (json) => json);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> updateBusiness(Map<String, dynamic> data) async {
    try {
      final response = await _client.dio.put(
        ApiEndpoints.businessProfile + '/update',
        data: data,
      );
      return ApiResponse.fromJson(response.data, (json) => json);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> uploadProof(File file) async {
    try {
      FormData formData = FormData.fromMap({
        'proof': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await _client.dio.post(
        ApiEndpoints.businessUploadProof,
        data: formData,
      );

      return ApiResponse.fromJson(response.data, (json) => json);
    } catch (e) {
      rethrow;
    }
  }
}
