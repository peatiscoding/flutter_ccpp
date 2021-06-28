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
    return await _api.makeTokenizedCreditCardPayment(req);
  }
}
