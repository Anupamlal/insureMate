import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        setUpNavigationBar()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .white
        appearance.backgroundColor = .white
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        let appearanceWhileScrolling = UINavigationBarAppearance()
        appearanceWhileScrolling.configureWithOpaqueBackground()
        appearanceWhileScrolling.shadowColor = .white
        appearanceWhileScrolling.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearanceWhileScrolling
    }
    
}
