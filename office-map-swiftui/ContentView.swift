import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      MapSelectorView()
    }
    .navigationViewStyle(.stack)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
