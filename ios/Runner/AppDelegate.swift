import UIKit
import Flutter
import GoogleMaps
import flutter_background_service_ios 

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.uturnsoftware.notification_identifier"
    GMSServices.provideAPIKey("AIzaSyD8CyWX66bVSqSklcAbTVQHdiRkeZzgcl0")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
