//
//  NormalTestView.swift
//  ThinkingInSwiftUI
//
//  Created by jeffy on 2022/5/3.
//

import SwiftUI

struct NormalTestView: View {
    @State var selected = false
    var body: some View {
        VStack {
            Button(action: { self.selected.toggle() }) {
                RoundedRectangle(cornerRadius: 10)
                .fill(.green)
                .frame(width: 50, height: 50) 
                .offset(x: -10, y: -10)
                .rotationEffect(Angle.degrees(selected ? 360 : 0))
            }
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: false), value: selected)
        }
    }
}

struct NormalTestView_Previews: PreviewProvider {
    static var previews: some View {
        NormalTestView()
    }
}
