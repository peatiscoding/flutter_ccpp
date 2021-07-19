import 'package:pigeon/pigeon.dart';

class MakeTokenizedCreditCardPaymentInput {
  String? paymentToken;
  String? cardToken;
  String? securityCode;
}

class MakePanCreditCardPaymentInput {
  String? panNumber;
  int? panExpiryMonth;
  int? panExpiryYear;
  bool? tokenizeCard;
  String? paymentToken;
  String? securityCode;
}

class MakePanCreditCardInstallmentPaymentInput {
  String? panNumber;
  int? panExpiryMonth;
  int? panExpiryYear;
  String? paymentToken;
  String? securityCode;
  int? period;
  bool? paidByCustomer;
}

class MakeTokenizedCreditCardInstallmentPaymentInput {
  String? paymentToken;
  String? cardToken;
  String? securityCode;
  int? period;
  bool? paidByCustomer;
}

class MakeQRPaymentInput {
  String? paymentToken;
  String? name;
  String? email;
  String? mobileNumber;

  /*
   * https://developer.2c2p.com/docs/reference-payment-channels#section-qr-payment-qrc-csqr-thqr-sgqr
   * "VEMVQR" | "PPQR" | "ALQR" | "WCQR" | "AMEXQR" | "MCEMVQR" | "JCBQR" | "UPIEMVQR" | "GPTQR" | "APQR" | "PNQR" | "GPQR" | "CBPQR" | "KBZQR" |"GIPQR"
   */
  String? channelCode;

  /*
   * "raw" | "base64" | "url"
   */
  String? qrCodeType;
}

class CcppPaymentResponse {
  String? responseCode;
  String? redirectUrl;
  String? error;

  // Only valid for QRPayment
  String? type; // Response Type
  String? data; // For Result 
}

@HostApi()
abstract class CcppApi {
  void setupProduction();
  void setupSandbox();

  @async
  CcppPaymentResponse makeTokenizedCreditCardPayment(MakeTokenizedCreditCardPaymentInput input);

  @async
  CcppPaymentResponse makePanCreditCardPayment(MakePanCreditCardPaymentInput input);

  @async
  CcppPaymentResponse makePanCreditCardInstallmentPayment(MakePanCreditCardInstallmentPaymentInput input);

  @async
  CcppPaymentResponse makeTokenizedCreditCardInstallmentPayment(MakeTokenizedCreditCardInstallmentPaymentInput input);

  @async
  CcppPaymentResponse makeQRPayment(MakeQRPaymentInput input);
}
