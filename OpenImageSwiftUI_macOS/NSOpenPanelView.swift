//
//  NSOpenPanelView.swift
//  OpenImageSwiftUI_macOS
//
//  Created by Genji on 2021/09/05.
//

import SwiftUI
import UniformTypeIdentifiers

struct NSOpenPanelView: View {

  @State private var image: NSImage? = nil

  var body: some View {
    VStack {
      Image(nsImage: image ?? NSImage())
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 500, height: 500)

      Button("Open") {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = [UTType.png.identifier, UTType.jpeg.identifier]
        if openPanel.runModal() == .OK {
          guard let url = openPanel.url,
                let newImage = NSImage(contentsOf: url)
          else { return }
          image = newImage
        }
      }
      .padding()
    }
  }
}

struct NSOpenPanelView_Previews: PreviewProvider {
  static var previews: some View {
    NSOpenPanelView()
  }
}
