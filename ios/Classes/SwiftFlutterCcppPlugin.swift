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

    public func makePanCreditCardInstallmentPayment(_ input: MakePanCreditCardInstallmentPaymentInput?, completion: @escaping (CcppPaymentResponse?, FlutterError?) -> Void) {
        guard let panNumber = input?.panNumber,
              let panExpiryMonth = input?.panExpiryMonth,
              let panExpiryYear = input?.panExpiryYear,
              let paymentToken = input?.paymentToken,
              let securityCode = input?.securityCode,
              let iPaidByCustomer = input?.paidByCustomer,
              let iPeriod = input?.period else {
            fatalError("Invalid request")
        }
        let paymentCode: PaymentCode = PaymentCode(channelCode: "IPP")
        let paidByCustomer: Bool = Bool(truncating: iPaidByCustomer)
        let paymentRequest: PaymentRequest = CardPaymentBuilder(paymentCode: paymentCode, panNumber)
            .expiryMonth(Int(truncating: panExpiryMonth))
            .expiryYear(Int(truncating: panExpiryYear))
            .securityCode(securityCode)
            .installmentInterestType(paidByCustomer ? InstallmentInterestTypeCode.Customer : InstallmentInterestTypeCode.Merchant)
            .installmentPeriod(Int(truncating: iPeriod))
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
    
    public func makeTokenizedCreditCardInstallmentPayment(_ input: MakeTokenizedCreditCardInstallmentPaymentInput?, completion: @escaping (CcppPaymentResponse?, FlutterError?) -> Void) {
        guard let cardToken = input?.cardToken,
              let paymentToken = input?.paymentToken,
              let iPaidByCustomer = input?.paidByCustomer,
              let iPeriod = input?.period,
              let securityCode = input?.securityCode else {
            fatalError("Invalid request")
        }
        let paymentCode: PaymentCode = PaymentCode(channelCode: "IPP")
        let paidByCustomer: Bool = Bool(truncating: iPaidByCustomer)
         
        let paymentRequest: PaymentRequest = CardTokenPaymentBuilder(paymentCode: paymentCode, cardToken)
            .securityCode(securityCode)
            .installmentInterestType(paidByCustomer ? InstallmentInterestTypeCode.Customer : InstallmentInterestTypeCode.Merchant)
            .installmentPeriod(Int(truncating: iPeriod))
            .build()
        let transactionResultRequest: TransactionResultRequest = TransactionResultRequestBuilder(paymentToken: paymentToken)
            .with(paymentRequest)
            .build()
    
        self.makePayment(request: transactionResultRequest, completion: completion)
    }
    
    public func makeQRPayment(_ input: MakeQRPaymentInput?, completion: @escaping (CcppPaymentResponse?, FlutterError?) -> Void) {
        guard let email = input?.email,
              let qrCodeType = input?.qrCodeType,
              let paymentToken = input?.paymentToken,
              let mobileNumber = input?.mobileNumber,
              let channelCode = input?.channelCode,
              let name = input?.name else {
            fatalError("Invalid request")
        }
        let paymentCode: PaymentCode = PaymentCode(channelCode: channelCode)
         
        let paymentRequest: PaymentRequest = QRPaymentBuilder(paymentCode: paymentCode)
            .type(makeQrType(qrCodeType))
            .name(name)
            .email(email)
            .mobileNo(mobileNumber)
            .build()
        let transactionResultRequest: TransactionResultRequest = TransactionResultRequestBuilder(paymentToken: paymentToken)
            .with(paymentRequest)
            .build()
    
        self.makePayment(request: transactionResultRequest, completion: completion)
    }
    
    private func makeQrType(_ type: String) -> String {
        if type == "raw" {
            return QRTypeCode.Raw
        } else if type == "base64" {
            return QRTypeCode.Base64
        }
        return QRTypeCode.URL
    }
    
    private func makePayment(request: TransactionResultRequest, completion: @escaping (CcppPaymentResponse?, FlutterError?) -> Void) {
        PGWSDK.shared.proceedTransaction(transactionResultRequest: request, { (response: TransactionResultResponse) in
            if response.responseCode == APIResponseCode.TransactionAuthenticateRedirect || response.responseCode == APIResponseCode.TransactionAuthenticateFullRedirect || response.responseCode == APIResponseCode.TransactionQRPayment || response.responseCode == APIResponseCode.APISuccess || response.responseCode == APIResponseCode.TransactionInProgress {
                   guard let redirectUrl: String = response.data else { return } //Open WebView
                let res = CcppPaymentResponse()
                res.redirectUrl = redirectUrl
                res.responseCode = response.responseCode
                res.data = response.data
                res.type = response.type
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
