class ResponseModel {
  final String message;
  final String qrCodeUrl;
  final String favoured;
  final String externalReference;
  final String checkout;
  final String pixKey;

  ResponseModel({
    required this.message,
    required this.qrCodeUrl,
    required this.favoured,
    required this.externalReference,
    required this.checkout,
    required this.pixKey,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        message: json['message'],
        qrCodeUrl: json['data']['qr_code_url'],
        favoured: json['data']['favoured'],
        externalReference: json['data']['external_reference'],
        checkout: json['data']['checkout'],
        pixKey: json['data']['pix_key'],
      );
}
