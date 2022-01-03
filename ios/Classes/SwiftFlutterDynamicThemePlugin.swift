import Flutter
import UIKit

public class SwiftFlutterDynamicThemePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_dynamic_theme", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterDynamicThemePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
