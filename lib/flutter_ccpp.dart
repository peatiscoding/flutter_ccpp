import 'dart:async';

import 'pigeon.dart';

enum CcppEnvironment {
  production,
  sandbox
}

enum QRType {
  raw,
  base64,
  url,
}

enum ChannelQRCode {
  alqr,
  wcqr,
  amexqr,
  vemvqr,
  mcemvqr,
  jcbqr,
  upiemvqr,
  ppqr,
  gpthqr,
  apqr,
  pnqr,
  gpqr,
  cbpqr,
  kbzqr,
  gipqr
}



class FlutterCcpp {
  static CcppApi? _apiInstance;

  static CcppApi get _api {
    if (_apiInstance == null) {
      _apiInstance = CcppApi();
    }
    return _apiInstance!;
  }

  static String makeChannelQRCode(ChannelQRCode qrCode) {
    switch (qrCode) {
      case ChannelQRCode.alqr: return "ALQR";
      case ChannelQRCode.wcqr: return "WCQR";
      case ChannelQRCode.amexqr: return "AMEXQR";
      case ChannelQRCode.vemvqr: return "VEMVQR";
      case ChannelQRCode.mcemvqr: return "MCEMVQR";
      case ChannelQRCode.jcbqr: return "JCBQR";
      case ChannelQRCode.upiemvqr: return "UPIEMVQR";
      case ChannelQRCode.ppqr: return "PPQR";
      case ChannelQRCode.gpthqr: return "GPTHQR";
      case ChannelQRCode.apqr: return "APQR";
      case ChannelQRCode.pnqr: return "PNQR";
      case ChannelQRCode.gpqr: return "GPQR";
      case ChannelQRCode.cbpqr: return "CBPQR";
      case ChannelQRCode.kbzqr: return "KBZQR";
      case ChannelQRCode.gipqr: return "GIPQR";
    }
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

  static Future<CcppPaymentResponse> makePanCreditCardInstallmentPayment(String paymentToken, String panNumber, panExpiryMonth, int panExpiryYear, String securityCode, bool paidByCustomer, int period) async {
    var req = MakePanCreditCardInstallmentPaymentInput();
    req.panNumber = panNumber;
    req.panExpiryMonth = panExpiryMonth;
    req.panExpiryYear = panExpiryYear;
    req.paymentToken = paymentToken;
    req.securityCode = securityCode;
    var resp = await _api.makePanCreditCardInstallmentPayment(req);
    if (resp.error != null) {
      throw Exception(resp.error);
    }
    return resp;
  }

  static Future<CcppPaymentResponse> makeTokenizedCreditCardInstallmentPayment(String paymentToken, String cardToken, String securityCode, bool paidByCustomer, int period) async {
    var req = MakeTokenizedCreditCardInstallmentPaymentInput();
    req.cardToken = cardToken;
    req.paymentToken = paymentToken;
    req.securityCode = securityCode;
    req.paymentToken = paymentToken;
    req.securityCode = securityCode;
    var resp = await _api.makeTokenizedCreditCardInstallmentPayment(req);
    if (resp.error != null) {
      throw Exception(resp.error);
    }
    return resp;
  }

  static Future<CcppPaymentResponse> makeQRPayment(ChannelQRCode channelCode, String paymentToken, String name, String mobileNumber, String email, QRType qrCodeType) async {
    var req = MakeQRPaymentInput();
    req.channelCode = FlutterCcpp.makeChannelQRCode(channelCode);
    req.paymentToken = paymentToken;
    req.name = name;
    req.mobileNumber = mobileNumber;
    req.email = email;
    if (QRType.base64 == qrCodeType) {
      req.qrCodeType = "base64";
    } else if (QRType.raw == qrCodeType) {
      req.qrCodeType = "raw";
    } else if (QRType.url == qrCodeType) {
      req.qrCodeType = "url";
    }
    var resp = await _api.makeQRPayment(req);
    if (resp.error != null) {
      throw Exception(resp.error);
    }
    return resp;
  }
}
