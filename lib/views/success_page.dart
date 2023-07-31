import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String buttonText;
  final String transactionSuccessMessage;

  const SuccessPage({
    super.key,
    required this.buttonText,
    required this.transactionSuccessMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/success.png'),
          Text(transactionSuccessMessage),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 28,
            ),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                },
                child: Text(
                  buttonText,
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
    );
  }
}
