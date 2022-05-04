//
//  Chapter3View.swift
//  ThinkingInSwiftUI
//
//  Created by jeffy on 2022/5/3.
//

import SwiftUI


struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1 // these are relative values
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        // 返回一个离矩形 rect 左右 dx, 上下 dy 的椭圆
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        
        return Path { p in
            p.addEllipse(in: circleRect)
            // Path 的坐标原点在左下角, 向右上增大
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

// MARK: - Environment Size
fileprivate struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get { self[PointerSizeKey.self] }
        set { self[PointerSizeKey.self] = newValue }
    }
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        self.environment(\.knobPointerSize, size)
    }
}

// MARK: - Environment Color

fileprivate struct PointerColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}

extension EnvironmentValues {
    var knobPointerColor: Color? {
        get { self[PointerColorKey.self] }
        set { self[PointerColorKey.self] = newValue }
    }
}

extension View {
    func knobPointerColor(_ color: Color?) -> some View {
        withAnimation(.default) {
            self.environment(\.knobPointerColor, color)
        }
    }
}

// MARK: - View

struct Knob: View {
    @Binding var value: Double // should be between 0 and 1
    var pointerSize: CGFloat? = nil
    @Environment(\.knobPointerSize) var envPointerSize
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.knobPointerColor) var color
    
    var body: some View {
         KnobShape(pointerSize: pointerSize ?? envPointerSize)
            .fill(color ?? (colorScheme == .dark ? .white : .black))
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                withAnimation(.default) {
                    self.value = self.value < 0.5 ? 1 : 0
                }
            }
    }
}

struct Chapter3View: View {
    
    @State var value: Double = 0.6
    @State var knobSize: CGFloat = 0.0
    @State var knobHue: CGFloat = 1.0
    @State var customColor: Bool = true

    var body: some View {
        VStack {
            Knob(value: $value)
                .frame(width: 100, height: 100)
                .knobPointerSize(knobSize)
                .knobPointerColor(customColor ? Color(hue: knobHue, saturation: 1, brightness: 1) : nil)
            HStack {
                Text("Value")
                Slider(value: $value, in: 0...1)
            }
            .padding()
            HStack {
                Text("Size:\(knobSize)")
                Slider(value: $knobSize, in: 0...0.4)
            }
            .padding()
            HStack {
                Text("Hue:\(knobHue)")
                Slider(value: $knobHue, in: 0...1.0)
            }
            .padding()
            Button("Toggle Size", action: {
                withAnimation(.default) {
                    value = value == 0 ? 1 : 0
                }
            })
            .padding()
            Button("Toggle Color", action: {
                customColor.toggle()
            })
        }
    }
}

struct Chapter3View_Previews: PreviewProvider {
    static var previews: some View {
        Chapter3View()
//            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
