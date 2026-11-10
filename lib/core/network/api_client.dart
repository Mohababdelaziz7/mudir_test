abstract class ApiClient {
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
}

class DefaultApiClient implements ApiClient {
  final String baseUrl;
  final Duration timeout;

  const DefaultApiClient({
    this.baseUrl = 'https://api.mudir.app/v1',
    this.timeout = const Duration(seconds: 30),
  });

  @override
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    // Standardized network client implementation placeholder ready for Dio / HTTP client
    return null;
  }

  @override
  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return null;
  }
}
