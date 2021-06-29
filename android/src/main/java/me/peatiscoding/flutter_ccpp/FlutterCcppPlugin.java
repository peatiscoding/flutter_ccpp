package me.peatiscoding.flutter_ccpp;

import android.content.Context;

import com.ccpp.pgw.sdk.android.builder.CardPaymentBuilder;
import com.ccpp.pgw.sdk.android.builder.CardTokenPaymentBuilder;
import com.ccpp.pgw.sdk.android.builder.PGWSDKParamsBuilder;
import com.ccpp.pgw.sdk.android.builder.TransactionResultRequestBuilder;
import com.ccpp.pgw.sdk.android.callback.APIResponseCallback;
import com.ccpp.pgw.sdk.android.core.PGWSDK;
import com.ccpp.pgw.sdk.android.enums.APIEnvironment;
import com.ccpp.pgw.sdk.android.enums.APIResponseCode;
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

  private void makePayment(TransactionResultRequest request, Pigeon.Result<Pigeon.CcppPaymentResponse> result) {
    // Step 5: Execute payment request.
    PGWSDK.getInstance().proceedTransaction(request, new APIResponseCallback<TransactionResultResponse>() {

      @Override
      public void onResponse(TransactionResultResponse response) {

        Pigeon.CcppPaymentResponse resp = new Pigeon.CcppPaymentResponse();
        resp.setResponseCode(response.getResponseCode());
        if(response.getResponseCode().equals(APIResponseCode.TransactionAuthenticateRedirect) || response.getResponseCode().equals(APIResponseCode.TransactionAuthenticateFullRedirect)) {
          String redirectUrl = response.getData(); //Open WebView
          resp.setRedirectUrl(redirectUrl);
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
