class GithubResponseError {
  final String message;
  final String documentationUrl;
  GithubResponseError({
    required this.message,
    required this.documentationUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "documentation_url": documentationUrl,
    };
  }

  factory GithubResponseError.fromJson(Map<String, dynamic> json) {
    return GithubResponseError(
      message: json["message"] ?? "",
      documentationUrl: json["documentation_url"] ?? "",
    );
  }
}
