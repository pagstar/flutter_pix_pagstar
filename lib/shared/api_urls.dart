class APIUrls {
  const APIUrls._();
  static const baseDevUrl =
      'https://dev-api.pagstar.com/api/v2/wallet/partner/transactions/generate-anonymous-pix';

  static const baseUrl =
      'https://api.pagstar.com/api/v2/wallet/partner/transactions/generate-anonymous-pix';

  static String checkDevTransaction(String transactionId) =>
      'https://dev-api.pagstar.com/api/v2/wallet/partner/transactions/$transactionId/check';

  static String checkTransaction(String transactionId) =>
      'https://api.pagstar.com/api/v2/wallet/partner/transactions/$transactionId/check';
}
