class PixTransactionModel {
  final double value;
  final String tenantId;
  final String? name;
  final String? document;
  final int expiration;

  PixTransactionModel({
    required this.value,
    required this.tenantId,
    this.name,
    this.document,
    this.expiration = 600,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'value': value,
      'tenant_id': tenantId,
      'expiration': expiration,
    };
    if (name != null && document != null) {
      data['name'] = name;
      data['document'] = document;
    }
    return data;
  }
}
