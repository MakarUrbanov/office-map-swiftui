import SwiftUI

struct MapSelectorView: View {
  @StateObject var viewModel = MapSelectorViewModel()

  @State var isPresentedImagePicker: Bool = false
  @State private var inputImage: UIImage?

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
      }, label: { Text("Open image picker") })
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
