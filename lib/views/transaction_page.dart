import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/response_model.dart';
import '../repositories/transactions_repository.dart';
import '../shared/themed_navigation.dart';
import 'success_page.dart';

class TransactionPage extends StatefulWidget {
  final ResponseModel responseModel;
  final double value;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final String feedbackText;
  final String cancelButtonLabel;
  final String successMessage;
  final String returnButtonLabel;

  const TransactionPage({
    super.key,
    required this.responseModel,
    required this.value,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.feedbackText,
    required this.cancelButtonLabel,
    required this.successMessage,
    required this.returnButtonLabel,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();

  static String formatCurrency(double value) {
    String raw = value.toStringAsFixed(2);
    String symbol = 'R\$ ';
    List<String> parts = raw.split('.');

    String decimalPart = parts.last;
    String integerPart = parts.first;

    final buffer = StringBuffer()
      ..write(symbol)
      ..write(integerPart.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match.group(0)},'))
      ..write(',')
      ..write(decimalPart);

    return buffer.toString();
  }
}

class _TransactionPageState extends State<TransactionPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startCheckTransactionTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startCheckTransactionTimer() {
    final TransactionsRepository transactionsRepository =
        TransactionsRepository();

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) async {
      bool transactionStatus = await transactionsRepository
          .checkTransaction(widget.responseModel.externalReference);

      if (transactionStatus && mounted) {
        await ThemedNavigation.pushReplacementWithTheme(
          context,
          SuccessPage(
            buttonText: widget.returnButtonLabel,
            transactionSuccessMessage: widget.successMessage,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return Builder(
              builder: (BuildContext innerContext) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Text(
                              TransactionPage.formatCurrency(widget.value),
                              style: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            widget.subtitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF828282),
                            ),
                          ),
                        ),
                        Center(
                          child: FutureBuilder(
                            future: precacheImage(
                                NetworkImage(widget.responseModel.qrCodeUrl),
                                context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                if (snapshot.error != null) {
                                  return const Text(
                                    'Erro ao carregar a imagem',
                                  );
                                } else {
                                  return Image.network(
                                    widget.responseModel.qrCodeUrl,
                                    scale: 0.4,
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 26),
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE0E0E0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Text(
                            widget.responseModel.pixKey,
                            maxLines: 1,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: widget.responseModel.pixKey));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(widget.feedbackText)),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: Text(
                                widget.buttonLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF009BE7),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
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
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                widget.cancelButtonLabel,
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
              },
            );
          }
        },
      ),
    );
  }
}
