import SwiftUI

struct MapSelectorView: View {
  @StateObject var viewModel = MapSelectorViewModel()
  @Environment(\.colorScheme) var colorScheme

  @State var isPresentedImagePicker: Bool = false
  @State private var inputImage: UIImage?
  @State var isNavigateToMap: Bool = false

  var body: some View {
    VStack {
      Text("Image will be here:")

      ZStack {
        viewModel.image?
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
      }
      .frame(width: 200, height: 200)
      .padding()
      .background(.gray.opacity(0.2))

      Button(action: {
        isPresentedImagePicker = true
      }, label: {
        Text("Open image picker")
        .padding()
        .frame(width: 300, height: 50)
        .foregroundColor(colorScheme == .dark ? .black : .white)
        .background(colorScheme == .dark ? .white.opacity(0.6) : .black.opacity(0.6))
        .cornerRadius(8)
        .padding(.top)
      })

      NavigationLink(
        destination: MapView(image: viewModel.image ?? Image(decorative: "error")),
        isActive: $isNavigateToMap
      ) {
        Button(action: {
          isNavigateToMap = true
        }, label: {
          ZStack {
            if viewModel.image != nil {
              Text("Next")
              .padding()
              .frame(width: 300, height: 50)
              .foregroundColor(colorScheme == .dark ? .black : .white)
              .background(colorScheme == .dark ? .white : .black)
              .cornerRadius(8)
              .padding(.top)
            }
          }
          .frame(width: 300, height: 50)
        })
      }

    }
    .navigationBarTitle("Map selection", displayMode: .inline)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onChange(of: inputImage) { _ in
      viewModel.loadImage(inputImage: inputImage)
    }
    .sheet(isPresented: $isPresentedImagePicker) {
      ImagePicker(image: $inputImage)
    }
  }
}
