import SwiftUI

struct MapView: View {
  @StateObject var viewModel = MapViewModel()
  @StateObject var gestureHandlers = GestureHandlers()
  let image: Image

  var body: some View {
    VStack {
      GeometryReader { geometry in
        ZStack {
          Image("MapBackground")
          .resizable()
          .scaledToFill()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .zIndex(1)

          MapImageView(gestureHandlers: gestureHandlers, image: image)
          .zIndex(2)

          Button(action: {
            gestureHandlers.refreshGestures()
          }, label: {
            Image(systemName: "arrow.clockwise.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.white)
          })
          .position(x: 50, y: geometry.size.height - 25)
          .zIndex(3)
          .shadow(color: .black.opacity(0.5), radius: 15, y: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped(antialiased: true)
        .gesture(gestureHandlers.panGestureHandler)
        .simultaneousGesture(gestureHandlers.rotationGestureHandler)
        .simultaneousGesture(gestureHandlers.pinchGestureHandler)

      }

      .navigationBarTitle("Map")
    }
  }
}
