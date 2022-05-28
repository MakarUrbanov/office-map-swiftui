import Foundation
import SwiftUI

class MapSelectorViewModel: ObservableObject {
  @Published var image: Image?

  init() {
    if let dataImageFromUserDefaults = UserDefaults.standard.data(forKey: "initialMapImage") {
      guard let imageFromData = UIImage(data: dataImageFromUserDefaults) else {
        return
      }

      self.image = Image(uiImage: imageFromData)
    }
  }

  func loadImage(inputImage: UIImage?) {
    guard let inputImage = inputImage else {
      return
    }

    image = Image(uiImage: inputImage)

    if let dataImage = inputImage.pngData() {
      UserDefaults.standard.set(dataImage, forKey: "initialMapImage")
    }
  }
}
