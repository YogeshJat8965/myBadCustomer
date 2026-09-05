import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/business_model.dart';
import '../services/api/business_api.dart';
import 'package:dio/dio.dart';

class BusinessProvider extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  BusinessModel? _business;
  bool _isLoading = false;
  String? _error;

  BusinessModel? get business => _business;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<bool> registerBusiness(Map<String, dynamic> data, File? proofFile) async {
    _setLoading(true);
    try {
      final response = await _businessApi.registerBusiness(data, proofFile);
      if (response.success && response.data != null) {
        _business = BusinessModel.fromJson(response.data!);
        notifyListeners();
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

  Future<void> fetchMyBusiness() async {
    _setLoading(true);
    try {
      final response = await _businessApi.getMyBusiness();
      if (response.success && response.data != null) {
        _business = BusinessModel.fromJson(response.data!);
        notifyListeners();
      } else {
        _error = response.message ?? 'Failed to fetch business profile';
      }
    } catch (e) {
      _error = _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateBusiness(Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      final response = await _businessApi.updateBusiness(data);
      if (response.success && response.data != null) {
        _business = BusinessModel.fromJson(response.data!);
        notifyListeners();
        return true;
      } else {
        _error = response.message ?? 'Update failed';
        return false;
      }
    } catch (e) {
      _error = _handleError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> uploadProof(File file) async {
    _setLoading(true);
    try {
      final response = await _businessApi.uploadProof(file);
      if (response.success && response.data != null) {
        _business = BusinessModel.fromJson(response.data!);
        notifyListeners();
        return true;
      } else {
        _error = response.message ?? 'Upload failed';
        return false;
      }
    } catch (e) {
      _error = _handleError(e);
      return false;
    } finally {
      _setLoading(false);
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
