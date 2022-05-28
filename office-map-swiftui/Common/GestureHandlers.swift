import Foundation
import SwiftUI

class GestureHandlers: ObservableObject {
  @Published private(set) var xOffset: CGFloat = 0
  private var lastXOffset: CGFloat = 0
  @Published private(set) var yOffset: CGFloat = 0
  private var lastYOffset: CGFloat = 0

  @Published private(set) var scaleValue: CGFloat = 1
  private var lastScaleValue: CGFloat = 1

  @Published private(set) var rotateAngle: Double = 0
  private var lastRotateAngle: Double = 0

  var panGestureHandler: some Gesture {
    DragGesture()
    .onChanged { [self] value in
      let xTranslate = value.translation.width / scaleValue
      let yTranslate = value.translation.height / scaleValue

      let sinOfRotation = sin(self.rotateAngle * Double(Float.pi) / 180)
      let cosOfRotation = cos(self.rotateAngle * Double(Float.pi) / 180)

      xOffset = lastXOffset + CGFloat(Double(xTranslate) * cosOfRotation + Double(yTranslate) * sinOfRotation)
      yOffset = lastYOffset + CGFloat(Double(xTranslate) * sinOfRotation * -1 + Double(yTranslate) * cosOfRotation)
    }
    .onEnded { [self] value in
      lastXOffset = self.xOffset
      lastYOffset = self.yOffset
    }
  }

  private func getCorrectScaleValue(_ value: CGFloat) -> CGFloat {
    return min(8, max(0.5, value))
  }

  var pinchGestureHandler: some Gesture {
    MagnificationGesture()
    .onChanged { [self] value in
      let resolvedDelta = value / self.lastScaleValue
      self.lastScaleValue = value
      let newScale = self.scaleValue * resolvedDelta

      self.scaleValue = getCorrectScaleValue(newScale)
    }
    .onEnded { value in
      self.lastScaleValue = 1
    }
  }

  func multiplyScaleValue(factor: Double) {
    let newScale = getCorrectScaleValue(self.scaleValue * factor)
    withAnimation(.easeInOut) {
      self.scaleValue = newScale
    }
  }

  var rotationGestureHandler: some Gesture {
    RotationGesture(minimumAngleDelta: .degrees(10))
    .onChanged { value in
      self.rotateAngle = self.lastRotateAngle + value.degrees
    }
    .onEnded { value in
      self.lastRotateAngle = self.rotateAngle
    }
  }

  func refreshGestures() {
    self.xOffset = 0
    self.lastXOffset = 0
    self.yOffset = 0
    self.lastYOffset = 0

    self.scaleValue = 1
    self.lastScaleValue = 1

    self.rotateAngle = 0
    self.lastRotateAngle = 0
  }
}
