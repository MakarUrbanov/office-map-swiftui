import Foundation
import SwiftUI

class MapSelectorViewModel: ObservableObject {
  @Published var image: Image?

  func loadImage(inputImage: UIImage?) {
    guard let inputImage = inputImage else {
      return
    }

    image = Image(uiImage: inputImage)
  }
}
