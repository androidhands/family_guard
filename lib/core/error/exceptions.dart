
class ServerException implements Exception {
  int code;
  String message;

  ServerException({required this.code, required this.message});
}

class CacheException implements Exception {
  int code;
  String message;

  CacheException({required this.code, required this.message});
}