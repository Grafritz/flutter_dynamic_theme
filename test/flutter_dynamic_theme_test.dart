import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dynamic_theme/flutter_dynamic_theme.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_dynamic_theme');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterDynamicTheme.platformVersion, '42');
  });
}
