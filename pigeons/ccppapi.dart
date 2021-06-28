import 'package:pigeon/pigeon.dart';

class MakeTokenizedCreditCardPaymentInput {
  String paymentToken;
  String cardToken;
  String securityCode;
}

class CcppPaymentResponse {
  String? responseCode;
  String? redirectUrl;
  String? error;
}

@HostApi()
abstract class CcppApi {
  void setupProduction();
  void setupSandbox();

  @async
  CcppPaymentResponse makeTokenizedCreditCardPayment(MakeTokenizedCreditCardPaymentInput input);
}
