import 'package:flutter/material.dart';

import '../flutter_pix_pagstar.dart';
import '../models/pix_transaction_model.dart';
import '../widgets/money_input_field.dart';

class SelectValuePage extends StatelessWidget {
  final String selectValueHeaderText;
  final String selectValueButtonText;
  final String subtitleText;
  final String transactionTitle;
  final String transactionButtonLabel;
  final String feedbackText;
  final String cancelButtonLabel;
  final String successMessage;
  final String returnButtonLabel;

  SelectValuePage({
    required this.selectValueHeaderText,
    required this.selectValueButtonText,
    required this.subtitleText,
    required this.transactionTitle,
    required this.transactionButtonLabel,
    required this.feedbackText,
    required this.cancelButtonLabel,
    required this.successMessage,
    required this.returnButtonLabel,
    Key? key,
  }) : super(key: key);

  final GlobalKey<MoneyInputFieldState> moneyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              selectValueHeaderText,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            MoneyInputField(
              onChanged: (value) {},
              key: moneyKey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 28,
              ),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    final value = moneyKey.currentState?.getMoneyValue();
                    if (value != null) {
                      if (value < 1 || value > 500) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid Value")),
                        );
                        return;
                      }
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Dialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      );
                      PixTransactionModel model = PixTransactionModel(
                        value: value,
                        tenantId: FlutterPixPagstar.tenantId,
                      );
                      FlutterPixPagstar.generateTransactionWithScreen(
                        context: context,
                        model: model,
                        title: transactionTitle,
                        buttonLabel: transactionButtonLabel,
                        feedbackText: feedbackText,
                        subtitle: subtitleText,
                        cancelButtonLabel: cancelButtonLabel,
                        successMessage: successMessage,
                        returnButtonLabel: returnButtonLabel,
                      );
                    }
                  },
                  child: Text(
                    selectValueButtonText,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
