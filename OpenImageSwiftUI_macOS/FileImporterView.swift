//
//  FileImporterView.swift
//  OpenImageSwiftUI_macOS
//
//  Created by Genji on 2021/09/05.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileImporterView: View {

  @State private var image: NSImage? = nil
  @State private var isImporterPresented = false

  var body: some View {
    VStack {
      Image(nsImage: image ?? NSImage())
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 500, height: 500)

      Button("Open") {
        isImporterPresented = true
      }
      .padding()
    }
    .fileImporter(isPresented: $isImporterPresented, allowedContentTypes: [.png, .jpeg]) { result in
      switch result {
      case .success(let url):
        guard let newImage = NSImage(contentsOf: url) else { return }
        image = newImage
      case .failure:
        print("failure")
      }
    }
  }
}

struct FileImporterView_Previews: PreviewProvider {
  static var previews: some View {
    FileImporterView()
  }
}
