flutter pub run pigeon \
  --input pigeons/ccppapi.dart \
  --dart_out lib/pigeon.dart \
  --objc_header_out ios/Classes/pigeon.h \
  --objc_source_out ios/Classes/pigeon.m \
  --java_out ./android/src/main/java/me/peatiscoding/flutter_ccpp/pigeon/Pigeon.java \
  --java_package "me.peatiscoding.flutter_ccpp.pigeon"
