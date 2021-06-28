import 'package:pigeon/pigeon.dart';

class CcppPaymentCode {
  String code;
}

class MakeTokenizedCreditCardPaymentInput {
  String paymentToken;
  CcppPaymentCode paymentCode;
  String cardToken;
  String securityCode;
}

class CcppPaymentResponse {
  String responseCode;
  String? redirectUrl;
}

@HostApi()
abstract class CcppApi {
  void setupProduction();
  void setupSandbox();

  @async
  CcppPaymentResponse makeTokenizedCreditCardPayment(MakeTokenizedCreditCardPaymentInput input);
}
