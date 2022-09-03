class ApiResponseError {
  final String message;
  final String documentationUrl;
  ApiResponseError({
    required this.message,
    required this.documentationUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "documentation_url": documentationUrl,
    };
  }

  factory ApiResponseError.fromJson(Map<String, dynamic> json) {
    return ApiResponseError(
      message: json["message"] ?? "",
      documentationUrl: json["documentation_url"] ?? "",
    );
  }
}
