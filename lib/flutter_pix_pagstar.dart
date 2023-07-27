import 'package:flutter/material.dart';

import 'models/pix_transaction_model.dart';
import 'models/response_model.dart';
import 'repositories/transactions_repository.dart';
import 'shared/themed_navigation.dart';
import 'views/error_page.dart';
import 'views/select_value_page.dart';
import 'views/transaction_page.dart';

class FlutterPixPagstar {
  static String authorization = '';
  static String tenantId = '';
  static ThemeData theme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        fixedSize: const Size(double.infinity, 56.0),
        disabledBackgroundColor: const Color(0xFF828282),
        backgroundColor: const Color(0xFF009BE7),
        elevation: 0.0,
      ),
    ),
  );

  FlutterPixPagstar._();

  static void init(
      {required String authorizationToken, required String tenant}) {
    authorization = authorizationToken;
    tenantId = tenant;
  }

  static void setTheme(ThemeData themeData) {
    theme = themeData;
  }

  static Future<bool> generateTransactionWithScreen({
    required BuildContext context,
    required PixTransactionModel model,
    required String title,
    required String buttonLabel,
    required String feedbackText,
    required String subtitle,
    required String cancelButtonLabel,
    required String successMessage,
    required String returnButtonLabel,
  }) async {
    final localContext = context;

    try {
      final TransactionsRepository transactionsRepository =
          TransactionsRepository();

      ResponseModel responseModel =
          await transactionsRepository.generateTransaction(model);

      // ignore: use_build_context_synchronously
      await ThemedNavigation.pushReplacementWithTheme(
        localContext,
        TransactionPage(
          responseModel: responseModel,
          value: model.value,
          title: title,
          buttonLabel: buttonLabel,
          feedbackText: feedbackText,
          subtitle: subtitle,
          cancelButtonLabel: cancelButtonLabel,
          successMessage: successMessage,
          returnButtonLabel: returnButtonLabel,
        ),
      );
      return true;
    } catch (e) {
      await ThemedNavigation.pushReplacementWithTheme(
        localContext,
        ErrorPage(error: e.toString()),
      );
      return false;
    }
  }

  static Future<bool> selectValuePage({
    required BuildContext context,
    required String headerText,
    required String buttonText,
    required String subtitleText,
    required String transactionTitle,
    required String transactionButtonLabel,
    required String feedbackText,
    required String cancelButtonLabel,
    required String successMessage,
    required String returnButtonLabel,
  }) async {
    final result = await ThemedNavigation.pushWithTheme(
      context,
      SelectValuePage(
        selectValueHeaderText: headerText,
        selectValueButtonText: buttonText,
        subtitleText: subtitleText,
        transactionTitle: transactionTitle,
        transactionButtonLabel: transactionButtonLabel,
        feedbackText: feedbackText,
        cancelButtonLabel: cancelButtonLabel,
        successMessage: successMessage,
        returnButtonLabel: returnButtonLabel,
      ),
    );

    if (result != null && result) {
      return result;
    }
    return false;
  }

  static Future<ResponseModel> generateTransaction(
      {required PixTransactionModel model}) async {
    final TransactionsRepository transactionsRepository =
        TransactionsRepository();

    return await transactionsRepository.generateTransaction(model);
  }

  static Future<bool> checkTransaction(
      {required String externalReference}) async {
    final TransactionsRepository transactionsRepository =
        TransactionsRepository();

    return await transactionsRepository.checkTransaction(externalReference);
  }
}
