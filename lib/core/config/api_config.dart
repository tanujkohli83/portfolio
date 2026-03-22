class ApiConfig {
  // API Configuration - Update this based on your environment
  // For production, consider using environment variables or a config file
  static const String baseUrl = "https://portfolio-backend-2xnz.onrender.com";
  static const String contactEndpoint = "/api/contact";

  static String get contactUrl => "$baseUrl$contactEndpoint";
}
