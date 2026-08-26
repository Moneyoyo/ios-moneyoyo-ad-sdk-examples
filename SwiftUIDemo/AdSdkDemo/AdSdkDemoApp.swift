//
//  AdSdkDemoApp.swift
//  AdSdkDemo
//
//  Created by admin on 26/8/26.
//
import MoneyoyoAdSDK
import SwiftUI

@main
struct AdSdkDemoApp: App {
  init() {
    Task {
      try await AdSDK.initialize(appKey: Config.appKey, isTest: true)
    }
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
