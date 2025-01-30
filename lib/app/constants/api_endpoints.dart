class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:5000/api/v1/";

  // static const String baseUrl = "http://localhost:3000/api/v1/";

  static const String login = "user/login";
  static const String register = "user";
  static const String uploadImage = "user/upload";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
}
