import Flutter
import UIKit
import GoogleMaps


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  //   if let apiKey = ProcessInfo.processInfo.environment["GOOGLE_MAPS_API_KEY"] {
  //      GMSServices.provideAPIKey(apiKey)
  //  }
    GMSServices.provideAPIKey("AIzaSyBBSekLvvFy9MAUoftpdhP6Q2sBvUg5XIs")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
