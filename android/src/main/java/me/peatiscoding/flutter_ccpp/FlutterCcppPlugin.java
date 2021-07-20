package me.peatiscoding.flutter_ccpp;

import android.content.Context;

import com.ccpp.pgw.sdk.android.builder.CardPaymentBuilder;
import com.ccpp.pgw.sdk.android.builder.CardTokenPaymentBuilder;
import com.ccpp.pgw.sdk.android.builder.PGWSDKParamsBuilder;
import com.ccpp.pgw.sdk.android.builder.QRPaymentBuilder;
import com.ccpp.pgw.sdk.android.builder.TransactionResultRequestBuilder;
import com.ccpp.pgw.sdk.android.callback.APIResponseCallback;
import com.ccpp.pgw.sdk.android.core.PGWSDK;
import com.ccpp.pgw.sdk.android.enums.APIEnvironment;
import com.ccpp.pgw.sdk.android.enums.APIResponseCode;
import com.ccpp.pgw.sdk.android.enums.InstallmentInterestTypeCode;
import com.ccpp.pgw.sdk.android.enums.QRTypeCode;
import com.ccpp.pgw.sdk.android.model.PaymentCode;
import com.ccpp.pgw.sdk.android.model.PaymentRequest;
import com.ccpp.pgw.sdk.android.model.api.TransactionResultRequest;
import com.ccpp.pgw.sdk.android.model.api.TransactionResultResponse;
import com.ccpp.pgw.sdk.android.model.core.PGWSDKParams;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodChannel;
import me.peatiscoding.flutter_ccpp.pigeon.Pigeon;

/** FlutterCcppPlugin */
public class FlutterCcppPlugin implements Pigeon.CcppApi, FlutterPlugin {

  private MethodChannel channel;
  private Context applicationContext;

  public void onAttachedToEngine(@NonNull FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
    this.applicationContext = flutterPluginBinding.getApplicationContext();
    Pigeon.CcppApi.setup(flutterPluginBinding.getBinaryMessenger(), this);
  }

  public void onDetachedFromEngine(@NonNull FlutterPlugin.FlutterPluginBinding binding) {
    this.applicationContext = null;
    Pigeon.CcppApi.setup(binding.getBinaryMessenger(), null);
  }

  public void setupProduction() {
    PGWSDKParams pgwsdkParams = new PGWSDKParamsBuilder(this.applicationContext, APIEnvironment.Production)
            .build();
    PGWSDK.initialize(pgwsdkParams);
  }

  public void setupSandbox() {
    PGWSDKParams pgwsdkParams = new PGWSDKParamsBuilder(this.applicationContext, APIEnvironment.Sandbox)
            .build();
    PGWSDK.initialize(pgwsdkParams);
  }

  public void makeTokenizedCreditCardPayment(Pigeon.MakeTokenizedCreditCardPaymentInput arg, Pigeon.Result<Pigeon.CcppPaymentResponse> result) {
    // Step 3: Construct credit card request.
    PaymentCode paymentCode = new PaymentCode("CC");

    PaymentRequest paymentRequest = new CardTokenPaymentBuilder(paymentCode, arg.getCardToken())
            .setSecurityCode(arg.getSecurityCode())
            .build();

    // Step 4: Construct transaction request.
    TransactionResultRequest transactionResultRequest = new TransactionResultRequestBuilder(arg.getPaymentToken())
            .with(paymentRequest)
            .build();
    this.makePayment(transactionResultRequest, result);
  }

  public void makeTokenizedCreditCardInstallmentPayment(Pigeon.MakeTokenizedCreditCardInstallmentPaymentInput arg, Pigeon.Result<Pigeon.CcppPaymentResponse> result) {
    // Step 3: Construct credit card request.
    PaymentCode paymentCode = new PaymentCode("IPP");

    PaymentRequest paymentRequest = new CardTokenPaymentBuilder(paymentCode, arg.getCardToken())
            .setSecurityCode(arg.getSecurityCode())
            .setInstallmentInterestType(arg.getPaidByCustomer() ? InstallmentInterestTypeCode.Customer : InstallmentInterestTypeCode.Merchant)
            .setInstallmentPeriod(Math.toIntExact(arg.getPeriod()))
            .build();

    // Step 4: Construct transaction request.
    TransactionResultRequest transactionResultRequest = new TransactionResultRequestBuilder(arg.getPaymentToken())
            .with(paymentRequest)
            .build();
    this.makePayment(transactionResultRequest, result);
  }

  @Override
  public void makePanCreditCardPayment(Pigeon.MakePanCreditCardPaymentInput arg, Pigeon.Result<Pigeon.CcppPaymentResponse> result) {
    // Step 3: Construct credit card request.
    PaymentCode paymentCode = new PaymentCode("CC");

    PaymentRequest paymentRequest = new CardPaymentBuilder(paymentCode, arg.getPanNumber())
            .setExpiryMonth(Math.toIntExact(arg.getPanExpiryMonth()))
            .setExpiryYear(Math.toIntExact(arg.getPanExpiryYear()))
            .setSecurityCode(arg.getSecurityCode())
            .setTokenize(arg.getTokenizeCard())
            .build();

    // Step 4: Construct transaction request.
    TransactionResultRequest transactionResultRequest = new TransactionResultRequestBuilder(arg.getPaymentToken())
            .with(paymentRequest)
            .build();
    this.makePayment(transactionResultRequest, result);
  }

  @Override
  public void makePanCreditCardInstallmentPayment(Pigeon.MakePanCreditCardInstallmentPaymentInput arg, Pigeon.Result<Pigeon.CcppPaymentResponse> result) {
    // Step 3: Construct credit card request.
    PaymentCode paymentCode = new PaymentCode("IPP");

    PaymentRequest paymentRequest = new CardPaymentBuilder(paymentCode, arg.getPanNumber())
            .setExpiryMonth(Math.toIntExact(arg.getPanExpiryMonth()))
            .setExpiryYear(Math.toIntExact(arg.getPanExpiryYear()))
            .setSecurityCode(arg.getSecurityCode())
            .setInstallmentInterestType(arg.getPaidByCustomer() ? InstallmentInterestTypeCode.Customer : InstallmentInterestTypeCode.Merchant)
            .setInstallmentPeriod(Math.toIntExact(arg.getPeriod()))
            .build();

    // Step 4: Construct transaction request.
    TransactionResultRequest transactionResultRequest = new TransactionResultRequestBuilder(arg.getPaymentToken())
            .with(paymentRequest)
            .build();
    this.makePayment(transactionResultRequest, result);
  }

  @Override
  public void makeQRPayment(Pigeon.MakeQRPaymentInput arg, Pigeon.Result<Pigeon.CcppPaymentResponse> result) {
    // Step 3: Construct qr request.
    PaymentCode paymentCode = new PaymentCode(arg.getChannelCode());

    QRPaymentBuilder qrPaymentBuilder = new QRPaymentBuilder(paymentCode)
            .setType(makeQRCodeType(arg.getQrCodeType()));

    if (arg.getName() != null && !arg.getName().isEmpty()) {
      qrPaymentBuilder.setName(arg.getName());
    }

    if (arg.getEmail() != null && !arg.getEmail().isEmpty()) {
      qrPaymentBuilder.setEmail(arg.getEmail());
    }

    if (arg.getMobileNumber() != null && !arg.getMobileNumber().isEmpty()) {
      qrPaymentBuilder.setMobileNo(arg.getMobileNumber());
    }

     PaymentRequest paymentRequest = qrPaymentBuilder.build();

    // Step 4: Construct transaction request.
    TransactionResultRequest transactionResultRequest = new TransactionResultRequestBuilder(arg.getPaymentToken())
            .with(paymentRequest)
            .build();
    this.makePayment(transactionResultRequest, result);
  }

  private String makeQRCodeType(String pigeonRawValue) {
    if ("raw".equals(pigeonRawValue)) {
      return QRTypeCode.Raw;
    } else if ("base64".equals(pigeonRawValue)) {
      return QRTypeCode.Base64;
    }
    return QRTypeCode.URL;
  }

  private void makePayment(TransactionResultRequest request, Pigeon.Result<Pigeon.CcppPaymentResponse> result) {
    // Step 5: Execute payment request.
    PGWSDK.getInstance().proceedTransaction(request, new APIResponseCallback<TransactionResultResponse>() {

      @Override
      public void onResponse(TransactionResultResponse response) {

        Pigeon.CcppPaymentResponse resp = new Pigeon.CcppPaymentResponse();
        resp.setResponseCode(response.getResponseCode());
        if(response.getResponseCode().equals(APIResponseCode.TransactionAuthenticateRedirect) || response.getResponseCode().equals(APIResponseCode.TransactionAuthenticateFullRedirect) || response.getResponseCode().equals(APIResponseCode.APISuccess) || response.getResponseCode().equals(APIResponseCode.TransactionInProgress) || response.getResponseCode().equals(APIResponseCode.TransactionQRPayment)) {
          String redirectUrl = response.getData(); //Open WebView
          resp.setRedirectUrl(redirectUrl);
          resp.setData(response.getData());
          resp.setType(response.getType());
        } else if(!response.getResponseCode().equals(APIResponseCode.TransactionCompleted)) {
          //Get error response and display error.
          // Work around while waiting for Pigeon to fix Error report mechanic.
          resp.setError("Unknown responseCode: " + response.getResponseCode());
        }
        result.success(resp);
      }

      @Override
      public void onFailure(Throwable error) {
        //Get error response and display error.
        Pigeon.CcppPaymentResponse resp = new Pigeon.CcppPaymentResponse();
        resp.setError("2c2p failed" + error.getLocalizedMessage());
      }
    });
  }
}
