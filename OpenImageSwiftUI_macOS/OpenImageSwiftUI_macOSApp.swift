//
//  OpenImageSwiftUI_macOSApp.swift
//  OpenImageSwiftUI_macOS
//
//  Created by Genji on 2021/09/05.
//

import SwiftUI

@main
struct OpenImageSwiftUI_macOSApp: App {
  var body: some Scene {
    WindowGroup {
      TabView {
        NSOpenPanelView()
          .tabItem { Text("NSOpenPanel") }
        FileImporterView()
          .tabItem { Text("fileImporter") }
        DropView()
          .tabItem { Text("onDrop") }
      }
      .padding()
    }
  }
}
