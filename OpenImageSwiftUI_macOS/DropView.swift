//
//  DropView.swift
//  OpenImageSwiftUI_macOS
//
//  Created by Genji on 2021/09/05.
//

import SwiftUI
import UniformTypeIdentifiers

struct DropView: View {

  @State private var image: NSImage? = nil
  @State private var isDropTargeted = false

  var body: some View {
    ZStack {
      Image(nsImage: image ?? NSImage())
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 500, height: 500)
      if isDropTargeted {
        Rectangle()
          .fill(Color(.windowBackgroundColor))
          .opacity(0.8)
          .overlay(
            Text("Drop Here")
              .font(.system(size: 64).bold())
          )
      }
    }
    .onDrop(of: [.png, .jpeg, .url, .fileURL], isTargeted: $isDropTargeted) { providers in
      guard let provider = providers.first
      else { return false }
      if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
        provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil) { data, error in
          guard let imageData = data as? Data,
                let newImage = NSImage(data: imageData)
          else { return }
          image = newImage
        }
      }
      else if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
        provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { data, error in
          guard let urlData = data as? Data,
                let url = URL(dataRepresentation: urlData, relativeTo: nil),
                let newImage = NSImage(contentsOf: url)
          else { return }
          image = newImage
        }
      }
      return true
    }
  }
}

struct DropView_Previews: PreviewProvider {
  static var previews: some View {
    DropView()
  }
}
