class ServerException implements Exception {
  final String message;
  const ServerException([this.message = "Server Error Occurred"]);

  @override
  String toString() {
    return message;
  }
}
