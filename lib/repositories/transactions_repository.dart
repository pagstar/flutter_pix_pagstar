import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import '../flutter_pix_pagstar.dart';
import '../models/pix_transaction_model.dart';
import '../models/response_model.dart';
import '../shared/api_urls.dart';

class TransactionsRepository {
  bool inDebugMode = false;

  Future<ResponseModel> generateTransaction(PixTransactionModel model) async {
    assert(inDebugMode = true);
    final response = await http.post(
      inDebugMode ? Uri.parse(APIUrls.baseDevUrl) : Uri.parse(APIUrls.baseUrl),
      headers: {
        'Authorization': 'Bearer ${FlutterPixPagstar.authorization}',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(model.toJson()),
    );
    developer.log(response.body);
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  Future<bool> checkTransaction(String reference) async {
    assert(inDebugMode = true);
    final response = await http.head(
      inDebugMode
          ? Uri.parse(APIUrls.checkDevTransaction(reference))
          : Uri.parse(APIUrls.checkTransaction(reference)),
      headers: {
        'Authorization': 'Bearer ${FlutterPixPagstar.authorization}',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
