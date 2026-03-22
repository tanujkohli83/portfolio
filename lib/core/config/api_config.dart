class ApiConfig {
  // API Configuration - Update this based on your environment
  // For production, consider using environment variables or a config file
  static const String baseUrl = "http://localhost:5000";
  static const String contactEndpoint = "/api/contact";

  static String get contactUrl => "$baseUrl$contactEndpoint";
}
