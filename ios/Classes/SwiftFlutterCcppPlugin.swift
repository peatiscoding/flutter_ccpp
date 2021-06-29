import Flutter
import UIKit
import PGW

public class SwiftFlutterCcppPlugin: NSObject, FlutterPlugin, CcppApi {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger: FlutterBinaryMessenger = registrar.messenger()
        let api: CcppApi = SwiftFlutterCcppPlugin()
        CcppApiSetup(messenger, api)
    }
    
    public func setupProduction(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let pgwsdkParams: PGWSDKParams = PGWSDKParamsBuilder(apiEnvironment: APIEnvironment.Production)
            .build()
        PGWSDK.initialize(params: pgwsdkParams)
    }
    
    public func setupSandbox(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let pgwsdkParams: PGWSDKParams = PGWSDKParamsBuilder(apiEnvironment: APIEnvironment.Sandbox)
            .build()
        PGWSDK.initialize(params: pgwsdkParams)
    }
    
    public func makePanCreditCardPayment(_ input: MakePanCreditCardPaymentInput?, completion: @escaping (CcppPaymentResponse?, FlutterError?) -> Void) {
        guard let panNumber = input?.panNumber,
              let panExpiryMonth = input?.panExpiryMonth,
              let panExpiryYear = input?.panExpiryYear,
              let tokenize = input?.tokenizeCard,
              let paymentToken = input?.paymentToken,
              let securityCode = input?.securityCode else {
            fatalError("Invalid request")
        }
        let paymentCode: PaymentCode = PaymentCode(channelCode: "CC")
        let paymentRequest: PaymentRequest = CardPaymentBuilder(paymentCode: paymentCode, panNumber)
            .expiryMonth(Int(truncating: panExpiryMonth))
            .expiryYear(Int(truncating: panExpiryYear))
            .tokenize(Bool(truncating: tokenize))
            .securityCode(securityCode)
            .build()
        let transactionResultRequest: TransactionResultRequest = TransactionResultRequestBuilder(paymentToken: paymentToken)
            .with(paymentRequest)
            .build()
    
        self.makePayment(request: transactionResultRequest, completion: completion)
    }
    
    public func makeTokenizedCreditCardPayment(_ input: MakeTokenizedCreditCardPaymentInput?, completion: @escaping (CcppPaymentResponse?, FlutterError?) -> Void) {
        guard let cardToken = input?.cardToken,
              let paymentToken = input?.paymentToken,
              let securityCode = input?.securityCode else {
            fatalError("Invalid request")
        }
        let paymentCode: PaymentCode = PaymentCode(channelCode: "CC")
         
        let paymentRequest: PaymentRequest = CardTokenPaymentBuilder(paymentCode: paymentCode, cardToken)
                                             .securityCode(securityCode)
                                             .build()
        let transactionResultRequest: TransactionResultRequest = TransactionResultRequestBuilder(paymentToken: paymentToken)
            .with(paymentRequest)
            .build()
    
        self.makePayment(request: transactionResultRequest, completion: completion)
    }
    
    private func makePayment(request: TransactionResultRequest, completion: @escaping (CcppPaymentResponse?, FlutterError?) -> Void) {
        PGWSDK.shared.proceedTransaction(transactionResultRequest: request, { (response: TransactionResultResponse) in
             if response.responseCode == APIResponseCode.TransactionAuthenticateRedirect || response.responseCode == APIResponseCode.TransactionAuthenticateFullRedirect {
                   guard let redirectUrl: String = response.data else { return } //Open WebView
                let res = CcppPaymentResponse()
                res.redirectUrl = redirectUrl
                res.responseCode = response.responseCode
                completion(res, nil)
             } else if response.responseCode == APIResponseCode.TransactionCompleted {
                let res = CcppPaymentResponse()
                res.responseCode = response.responseCode
                // Inquiry payment result by using invoice no.
                completion(res, nil)
             } else {
                // Get error response and display error.
                completion(nil, FlutterError(
                            code: response.responseCode,
                            message: "Unknown responseCode: \(String(describing: response.responseCode))",
                            details: nil))
             }
        }) { (error: NSError) in
             // Get error response and display error.
            completion(nil, FlutterError(code: "\(error.code)", message: error.localizedDescription, details: nil))
        }
    }
    
}
