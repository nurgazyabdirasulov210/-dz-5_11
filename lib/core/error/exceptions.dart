
class ServerExceptions implements Exception {
  final String message;
  const ServerExceptions(this.message);
}

class NetworkExceptions implements Exception {
  final String message;
  const NetworkExceptions(this.message);
}