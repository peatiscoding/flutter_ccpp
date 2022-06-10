import 'dart:async';

import 'pigeon.dart';

enum CcppEnvironment { production, sandbox }

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

const Map<String, String> responseCodeMap = {
  "0000": "API success",
  "9004": "The {0} value is not valid",
  "9005": "Some mandatory fields are missing",
  "9006": "This fields exceeded their authorized length",
  "9007": "Invalid merchant",
  "9008": "Invalid payment expiry",
  "9009": "Amount is invalid",
  "9010": "Invalid CurrencyCode",
  "9012": "paymentItem name is required",
  "9013": "paymentItem quantity is required",
  "9014": "paymentItem amount is required",
  "9015": "Existed Invoice Number",
  "9035": "Payment failed",
  "9037": "Merchant configuration is missing",
  "9038": "Failed To Generate Token",
  "9039": "The merchant frontend url is missing",
  "9040": "The token is invalid",
  "9041": "Payment Token already used",
  "9042": "Hash Value Mismatch",
  "9057": "Payment options are invalid",
  "9058": "Payment channel invalid",
  "9059": "Payment channel unauthorized",
  "9060": "Payment channel unconfigured",
  "9078": "Promotion code does not exist",
  "9080": "Tokenize Not Allow",
  "9088": "SubMerchant is required",
  "9089": "Duplicated SubMerchant",
  "9090": "SubMerchant Not Found",
  "9091": "Invalid Sub Merchant ID",
  "9092": "Invalid Sub Merchant invoiceNo",
  "9093": "Existing Sub Merchant Invoice Number",
  "9094": "Invalid Sub Merchant Amount",
  "9095": "Sub Merchant Amount MissMatch",
  "9901": "Invalid invoicePrefix",
  "9902": "allowAccumulate is required",
  "9903": "maxAccumulateAmount is required",
  "9904": "recurringInterval or ChargeOnDate is Required",
  "9905": "recurringCount is required",
  "9906": "recurringInterval or ChargeOnDate is Required",
  "9907": "Invalid ChargeNextDate",
  "9908": "Invalid ChargeOnDate",
  "9909": "chargeNextDate is required",
  "9990": "Request to merchant front end has failed",
  "9991": "Request merchant secure has failed",
  "9992": "Request payment secure has failed",
  "9993": "An unknown error has occured",
  "9994": "Request DB service has failed",
  "9995": "Request Payment service has failed",
  "9996": "Request Qwik service has failed",
  "9997": "Request User preferences has failed",
  "9998": "Request store card has failed.",
  "9999": "Request to merchant back end has failed"
};

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
      case ChannelQRCode.alqr:
        return "ALQR";
      case ChannelQRCode.wcqr:
        return "WCQR";
      case ChannelQRCode.amexqr:
        return "AMEXQR";
      case ChannelQRCode.vemvqr:
        return "VEMVQR";
      case ChannelQRCode.mcemvqr:
        return "MCEMVQR";
      case ChannelQRCode.jcbqr:
        return "JCBQR";
      case ChannelQRCode.upiemvqr:
        return "UPIEMVQR";
      case ChannelQRCode.ppqr:
        return "PPQR";
      case ChannelQRCode.gpthqr:
        return "GPTHQR";
      case ChannelQRCode.apqr:
        return "APQR";
      case ChannelQRCode.pnqr:
        return "PNQR";
      case ChannelQRCode.gpqr:
        return "GPQR";
      case ChannelQRCode.cbpqr:
        return "CBPQR";
      case ChannelQRCode.kbzqr:
        return "KBZQR";
      case ChannelQRCode.gipqr:
        return "GIPQR";
    }
  }

  static String mapResponseCode(String responseCode) {
    String? responseMessage = responseCodeMap[responseCode];
    if (responseMessage == null) {
      return "Unknown Code: " + responseCode;
    }
    return responseMessage;
  }

  // Expose as public method
  static setup(CcppEnvironment env) {
    if (env == CcppEnvironment.production) {
      return _api.setupProduction();
    }
    return _api.setupSandbox();
  }

  static Future<CcppPaymentResponse> makeTokenizedCreditCardPayment(
      String paymentToken, String cardToken, String securityCode) async {
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

  static Future<CcppPaymentResponse> makePanCreditCardPayment(
      String paymentToken,
      String panNumber,
      int panExpiryMonth,
      int panExpiryYear,
      String securityCode,
      bool tokenizeCard) async {
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

  static Future<CcppPaymentResponse> makePanCreditCardInstallmentPayment(
      String paymentToken,
      String panNumber,
      panExpiryMonth,
      int panExpiryYear,
      String securityCode,
      bool paidByCustomer,
      int period) async {
    var req = MakePanCreditCardInstallmentPaymentInput();
    req.panNumber = panNumber;
    req.panExpiryMonth = panExpiryMonth;
    req.panExpiryYear = panExpiryYear;
    req.paymentToken = paymentToken;
    req.securityCode = securityCode;
    req.period = period;
    req.paidByCustomer = paidByCustomer;
    var resp = await _api.makePanCreditCardInstallmentPayment(req);
    if (resp.error != null) {
      throw Exception(resp.error);
    }
    return resp;
  }

  static Future<CcppPaymentResponse> makeTokenizedCreditCardInstallmentPayment(
      String paymentToken,
      String cardToken,
      String securityCode,
      bool paidByCustomer,
      int period) async {
    var req = MakeTokenizedCreditCardInstallmentPaymentInput();
    req.cardToken = cardToken;
    req.paymentToken = paymentToken;
    req.securityCode = securityCode;
    req.paymentToken = paymentToken;
    req.period = period;
    req.paidByCustomer = paidByCustomer;
    var resp = await _api.makeTokenizedCreditCardInstallmentPayment(req);
    if (resp.error != null) {
      throw Exception(resp.error);
    }
    return resp;
  }

  static Future<CcppPaymentResponse> makeQRPayment(
      ChannelQRCode channelCode,
      String paymentToken,
      String? name,
      String? mobileNumber,
      String? email,
      QRType qrCodeType) async {
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

  static setAutoResetSSLSocket(bool isEnabled) async {
    await _api.setAutoResetSSLSocket(isEnabled);
  }
}
