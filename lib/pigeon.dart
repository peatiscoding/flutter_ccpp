// Autogenerated from Pigeon (v0.3.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/services.dart';

class MakeTokenizedCreditCardPaymentInput {
  String? paymentToken;
  String? cardToken;
  String? securityCode;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['paymentToken'] = paymentToken;
    pigeonMap['cardToken'] = cardToken;
    pigeonMap['securityCode'] = securityCode;
    return pigeonMap;
  }

  static MakeTokenizedCreditCardPaymentInput decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MakeTokenizedCreditCardPaymentInput()
      ..paymentToken = pigeonMap['paymentToken'] as String?
      ..cardToken = pigeonMap['cardToken'] as String?
      ..securityCode = pigeonMap['securityCode'] as String?;
  }
}

class MakePanCreditCardPaymentInput {
  String? panNumber;
  int? panExpiryMonth;
  int? panExpiryYear;
  bool? tokenizeCard;
  String? paymentToken;
  String? securityCode;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['panNumber'] = panNumber;
    pigeonMap['panExpiryMonth'] = panExpiryMonth;
    pigeonMap['panExpiryYear'] = panExpiryYear;
    pigeonMap['tokenizeCard'] = tokenizeCard;
    pigeonMap['paymentToken'] = paymentToken;
    pigeonMap['securityCode'] = securityCode;
    return pigeonMap;
  }

  static MakePanCreditCardPaymentInput decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MakePanCreditCardPaymentInput()
      ..panNumber = pigeonMap['panNumber'] as String?
      ..panExpiryMonth = pigeonMap['panExpiryMonth'] as int?
      ..panExpiryYear = pigeonMap['panExpiryYear'] as int?
      ..tokenizeCard = pigeonMap['tokenizeCard'] as bool?
      ..paymentToken = pigeonMap['paymentToken'] as String?
      ..securityCode = pigeonMap['securityCode'] as String?;
  }
}

class MakePanCreditCardInstallmentPaymentInput {
  String? panNumber;
  int? panExpiryMonth;
  int? panExpiryYear;
  String? paymentToken;
  String? securityCode;
  int? period;
  bool? paidByCustomer;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['panNumber'] = panNumber;
    pigeonMap['panExpiryMonth'] = panExpiryMonth;
    pigeonMap['panExpiryYear'] = panExpiryYear;
    pigeonMap['paymentToken'] = paymentToken;
    pigeonMap['securityCode'] = securityCode;
    pigeonMap['period'] = period;
    pigeonMap['paidByCustomer'] = paidByCustomer;
    return pigeonMap;
  }

  static MakePanCreditCardInstallmentPaymentInput decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MakePanCreditCardInstallmentPaymentInput()
      ..panNumber = pigeonMap['panNumber'] as String?
      ..panExpiryMonth = pigeonMap['panExpiryMonth'] as int?
      ..panExpiryYear = pigeonMap['panExpiryYear'] as int?
      ..paymentToken = pigeonMap['paymentToken'] as String?
      ..securityCode = pigeonMap['securityCode'] as String?
      ..period = pigeonMap['period'] as int?
      ..paidByCustomer = pigeonMap['paidByCustomer'] as bool?;
  }
}

class MakeTokenizedCreditCardInstallmentPaymentInput {
  String? paymentToken;
  String? cardToken;
  String? securityCode;
  int? period;
  bool? paidByCustomer;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['paymentToken'] = paymentToken;
    pigeonMap['cardToken'] = cardToken;
    pigeonMap['securityCode'] = securityCode;
    pigeonMap['period'] = period;
    pigeonMap['paidByCustomer'] = paidByCustomer;
    return pigeonMap;
  }

  static MakeTokenizedCreditCardInstallmentPaymentInput decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MakeTokenizedCreditCardInstallmentPaymentInput()
      ..paymentToken = pigeonMap['paymentToken'] as String?
      ..cardToken = pigeonMap['cardToken'] as String?
      ..securityCode = pigeonMap['securityCode'] as String?
      ..period = pigeonMap['period'] as int?
      ..paidByCustomer = pigeonMap['paidByCustomer'] as bool?;
  }
}

class MakeQRPaymentInput {
  String? paymentToken;
  String? name;
  String? email;
  String? mobileNumber;
  String? channelCode;
  String? qrCodeType;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['paymentToken'] = paymentToken;
    pigeonMap['name'] = name;
    pigeonMap['email'] = email;
    pigeonMap['mobileNumber'] = mobileNumber;
    pigeonMap['channelCode'] = channelCode;
    pigeonMap['qrCodeType'] = qrCodeType;
    return pigeonMap;
  }

  static MakeQRPaymentInput decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MakeQRPaymentInput()
      ..paymentToken = pigeonMap['paymentToken'] as String?
      ..name = pigeonMap['name'] as String?
      ..email = pigeonMap['email'] as String?
      ..mobileNumber = pigeonMap['mobileNumber'] as String?
      ..channelCode = pigeonMap['channelCode'] as String?
      ..qrCodeType = pigeonMap['qrCodeType'] as String?;
  }
}

class CcppPaymentResponse {
  String? responseCode;
  String? redirectUrl;
  String? error;
  String? type;
  String? data;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['responseCode'] = responseCode;
    pigeonMap['redirectUrl'] = redirectUrl;
    pigeonMap['error'] = error;
    pigeonMap['type'] = type;
    pigeonMap['data'] = data;
    return pigeonMap;
  }

  static CcppPaymentResponse decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return CcppPaymentResponse()
      ..responseCode = pigeonMap['responseCode'] as String?
      ..redirectUrl = pigeonMap['redirectUrl'] as String?
      ..error = pigeonMap['error'] as String?
      ..type = pigeonMap['type'] as String?
      ..data = pigeonMap['data'] as String?;
  }
}

class CcppApi {
  /// Constructor for [CcppApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  CcppApi({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  Future<void> setupProduction() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.CcppApi.setupProduction', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      // noop
    }
  }

  Future<void> setupSandbox() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.CcppApi.setupSandbox', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      // noop
    }
  }

  Future<CcppPaymentResponse> makeTokenizedCreditCardPayment(MakeTokenizedCreditCardPaymentInput arg) async {
    final Object encoded = arg.encode();
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.CcppApi.makeTokenizedCreditCardPayment', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return CcppPaymentResponse.decode(replyMap['result']!);
    }
  }

  Future<CcppPaymentResponse> makePanCreditCardPayment(MakePanCreditCardPaymentInput arg) async {
    final Object encoded = arg.encode();
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.CcppApi.makePanCreditCardPayment', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return CcppPaymentResponse.decode(replyMap['result']!);
    }
  }

  Future<CcppPaymentResponse> makePanCreditCardInstallmentPayment(MakePanCreditCardInstallmentPaymentInput arg) async {
    final Object encoded = arg.encode();
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.CcppApi.makePanCreditCardInstallmentPayment', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return CcppPaymentResponse.decode(replyMap['result']!);
    }
  }

  Future<CcppPaymentResponse> makeTokenizedCreditCardInstallmentPayment(MakeTokenizedCreditCardInstallmentPaymentInput arg) async {
    final Object encoded = arg.encode();
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.CcppApi.makeTokenizedCreditCardInstallmentPayment', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return CcppPaymentResponse.decode(replyMap['result']!);
    }
  }

  Future<CcppPaymentResponse> makeQRPayment(MakeQRPaymentInput arg) async {
    final Object encoded = arg.encode();
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.CcppApi.makeQRPayment', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return CcppPaymentResponse.decode(replyMap['result']!);
    }
  }

  Future<void> setAutoResetSSLSocket(bool arg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.CcppApi.setAutoResetSSLSocket', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
    await channel.send(arg) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      // noop
    }
  }
}
