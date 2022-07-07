//
//  SceneDelegate.swift
//  SubwayStation
//
//  Created by HwangByungJo  on 2022/07/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScen = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScen)
    window?.backgroundColor = .systemBackground
    window?.rootViewController = UINavigationController(rootViewController: StationSearchViewController())
    window?.makeKeyAndVisible()
  }

}

