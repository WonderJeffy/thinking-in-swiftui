//
//  ContentView.swift
//  ThinkingInSwiftUI
//
//  Created by jeffy on 2022/5/3.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented = false

    var body: some View {
        NavigationView() {
            VStack {
                Text("Thingking in SwiftUI")
                    .fontWeight(.bold)
                List {
                    Section {
                        NavigationLink("Test", destination: NormalTestView())
                    }
                    Section("Chapter2") {
                        PresentLink("Exercise", destination: Chapter2View())
                    }
                    Section("Chapter3") {
                        NavigationLink("Exercise", destination: Chapter3View())
                    }
                    Section("Chapter4") {
                        NavigationLink("Exercise", destination: Chapter4View())
                    }
                }
                
            }
            .navigationTitle("Home Page")
            .navigationBarHidden(true)
        }
    }
}

extension ContentView {
    
    func PresentLink<Destination>(_ title: String, destination: Destination) -> some View where Destination : View {
        
        return Button(
            action: {
                self.isPresented.toggle()
            }) {
                Text(title)
            }
            .sheet(isPresented: $isPresented, content: {destination})
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
#if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ContentView())
    }
#endif
}
