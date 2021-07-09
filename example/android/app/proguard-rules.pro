## Flutter wrapper
#noinspection ShrinkerUnresolvedReference
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

#Mandatory for PGW SDK
#2C2P PGW Library
-keep class com.ccpp.pgw.** { *; }

