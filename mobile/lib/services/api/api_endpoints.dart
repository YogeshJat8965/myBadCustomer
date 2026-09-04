class ApiEndpoints {
  // Since we are using an actual device (Pixel 7a) via USB debugging, 
  // we cannot use 10.0.2.2 (which is for emulator).
  // We need to use the local IP address of the laptop.
  // TODO: The user should replace '192.168.x.x' with their actual IP address.
  static const String baseUrl = 'http://192.168.1.100:3000/api/v1';

  // Auth
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/auth/profile';
  static const String logout = '/auth/logout';

  // Business
  static const String businessRegister = '/business/register';
  static const String businessProfile = '/business/profile';
  static const String businessUploadProof = '/business/upload-proof';

  // Search & Customer
  static const String searchCustomer = '/customers/search';
  static const String customerDetail = '/customers';

  // Reports
  static const String createReport = '/reports';
  static const String listReports = '/reports';
  static const String reportDetail = '/reports';
  
  // Evidence
  static const String uploadEvidence = '/reports/evidence';
}
