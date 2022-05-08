//
//  Chapter4View.swift
//  ThinkingInSwiftUI
//
//  Created by jeffy on 2022/5/4.
//

import SwiftUI

struct Collapsible<Element, Content: View>: View {
    
    @State var expanded: Bool = false
    var data: [Element]
    var content: (Element) -> Content
    
    let collapseWidth = 10.0
    
    init(data: [Element], @ViewBuilder content: @escaping (Element) -> Content) {
        
        self.data = data
        self.content = content
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: nil) {
                ForEach(data.indices, id: \.self){ index in
                    let showExpanded = (expanded || index == data.endIndex-1)
                    content(data[index])
                        .frame(width: showExpanded ? nil : collapseWidth, height: nil)
                }
            }
            .padding(88)
            Text(expanded ? "collapse" : " expand ")
                .frame(width: 88, height: 44, alignment: .center)
                .badge(4)
                .background(expanded ? .blue : .orange)
                .cornerRadius(22)
                .onTapGesture {
                    withAnimation {
                        expanded.toggle()
                    }
                }
        }
    }
}

extension View {
    
    func redBadge(count:Int?) -> some View {
        overlay(
            ZStack {
                if let count = count {
                    Circle()
                        .fill(.red)
                    Text("\(count)")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .offset(x: 12, y: -12)
            .frame(width: 24, height: 24, alignment: .center)
            ,alignment: .topTrailing
        )
    }
}

struct Chapter4View: View {
    var body: some View {
        VStack {
            Collapsible(data: [1,2,3,4,5,6]) { element in
                Rectangle()
                    .fill(Color(hue: Double(element)/6.0, saturation: 1, brightness: 1))
                    .frame(width: 44+Double(element), height: 44+Double(element), alignment: .center)
            }
            .padding()
            List {
                // 官方 badge
                Text("Recents")
                    .badge(10)
                
            }
            .frame(width: nil, height: 88, alignment: .center)
            .padding(10)
            // 自定义 badge
            Text("Favorites")
                .redBadge(count: 10)
        }
    }
}

struct Chapter4View_Previews: PreviewProvider {
    static var previews: some View {
        Chapter4View()
    }
}
