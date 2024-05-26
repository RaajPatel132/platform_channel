import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
       
        let flutterViewController = window.rootViewController as! FlutterViewController
        
        let flutterMethodChannel = FlutterMethodChannel(name: "BatteryInformation", binaryMessenger: flutterViewController.binaryMessenger)
        
        flutterMethodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if call.method == "getBatteryLevel" {
                let batteryLevel = self.getBatteryLevel()
                
                guard batteryLevel != -1 else {
                    result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available", details: "Battery State is unknown"))
                    return
                }
                
                result(batteryLevel)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func getBatteryLevel() -> Int {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        
        guard device.batteryState != UIDevice.BatteryState.unknown else {
            return -1
        }
        
        return Int(device.batteryLevel * 100)
        
    }
}
