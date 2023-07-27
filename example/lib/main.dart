import 'package:flutter/material.dart';
import 'package:flutter_pix_pagstar/flutter_pix_pagstar.dart';

void main() {
  //TODO: input your credentials
  FlutterPixPagstar.init(
    authorizationToken: '622779|19IpjXAE0p1kMYYeGoeZKur5N8xFMQpzq6IKusRb',
    tenant: 'fedaac64-92f9-4a2a-b91e-007d6081f469',
  );
  //PixPagstar.setTheme(ThemeData.dark());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pix Pagstar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pix Pagstar Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Pix Pagstar example!',
            ),
            ElevatedButton(
              onPressed: () {
                FlutterPixPagstar.selectValuePage(
                  context: context,
                  headerText: "Digite o valor do Pix",
                  buttonText: "CONTINUAR",
                  transactionTitle: "Copie o código para pagar",
                  subtitleText:
                      "Escolha a opção de pagar com Pix e cole o código abaixo:",
                  transactionButtonLabel: "COPIAR CÓDIGO",
                  feedbackText: "Copiado para a área de tranferência!",
                  cancelButtonLabel: "CANCELAR",
                  successMessage: 'Pagamento recebido',
                  returnButtonLabel: "Voltar ao início",
                );
              },
              child: const Text('Create Pix Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
