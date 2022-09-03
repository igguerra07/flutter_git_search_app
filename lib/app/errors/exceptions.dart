class NoConnectionException implements Exception {
  final String message;

  const NoConnectionException({
    this.message = "Unable to connect to the internet",
  });

  @override
  String toString() => "NoConnectionException: $message";
}

class FormatException implements Exception {
  final String message;

  const FormatException({
    this.message = "Unable to process data",
  });

  @override
  String toString() => "FormatException: $message";
}

class NotFoundException implements Exception {
  final String path;
  final String message;

  const NotFoundException({
    required this.path,
    this.message = "Not found",
  });

  @override
  String toString() => "NotFoundException:\nPath: $path\nMessage: $message";
}
class NoAuthorizedException implements Exception {
  final String path;
  final String message;

  const NoAuthorizedException({
    required this.path,
    this.message = "No Authorized",
  });

  @override
  String toString() => "NoAuthorizedException:\nPath: $path\nMessage: $message";
}

class ServerResponseException implements Exception {
  final String message;
  final int statusCode;

  const ServerResponseException({
    required this.statusCode,
    this.message = "Error from server",
  });

  @override
  String toString() =>
      "ServerResponseException:\nStatus code [$statusCode]\nResponse: $message";
}
