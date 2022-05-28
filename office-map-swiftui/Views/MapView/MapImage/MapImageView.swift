import SwiftUI

struct MapImageView: View {
  @ObservedObject var gestureHandlers: GestureHandlers
  let image: Image

  var body: some View {
    VStack {
      image
      .resizable()
      .scaledToFit()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .offset(x: gestureHandlers.xOffset, y: gestureHandlers.yOffset)
      .scaleEffect(gestureHandlers.scaleValue, anchor: .center)
      .rotationEffect(.degrees(gestureHandlers.rotateAngle))

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
