# flutter_ccpp

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Configuring Obfuscation Scripts

#### Android (ProGuard)

Before building the APK, configure the obfuscation file to prevent the CCPP from being obfuscated.

Add this line to your proguard file.

```
#Mandatory for PGW SDK
#2C2P PGW Library
-keep class com.ccpp.pgw.** { *; }
```
