import 'dart:async';

import 'pigeon.dart';

enum CcppEnvironment {
  production,
  sandbox
}

class FlutterCcpp {
  static CcppApi? _apiInstance;

  static CcppApi get _api {
    if (_apiInstance == null) {
      _apiInstance = CcppApi();
    }
    return _apiInstance!;
  }

  // Expose as public method
  static setup(CcppEnvironment env) {
    if (env == CcppEnvironment.production) {
      return _api.setupProduction();
    }
    return _api.setupSandbox();
  }

  static Future<CcppPaymentResponse> makeTokenizedCreditCardPayment(String paymentToken, String cardToken, String securityCode) async {
    var req = MakeTokenizedCreditCardPaymentInput();
    req.cardToken = cardToken;
    req.paymentToken = paymentToken;
    req.securityCode = securityCode;
    var resp = await _api.makeTokenizedCreditCardPayment(req);
    if (resp.error != null) {
      throw Exception(resp.error);
    }
    return resp;
  }

  static Future<CcppPaymentResponse> makePanCreditCardPayment(String paymentToken, String panNumber, int panExpiryMonth, int panExpiryYear, String securityCode, bool tokenizeCard) async {
    var req = MakePanCreditCardPaymentInput();
    req.panNumber = panNumber;
    req.panExpiryMonth = panExpiryMonth;
    req.panExpiryYear = panExpiryYear;
    req.tokenizeCard = tokenizeCard;
    req.paymentToken = paymentToken;
    req.securityCode = securityCode;
    var resp = await _api.makePanCreditCardPayment(req);
    if (resp.error != null) {
      throw Exception(resp.error);
    }
    return resp;
  }
}
