//
//  ContentView.swift
//  Chapter2-Exercise
//
//  Created by jeffy on 2022/5/2.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var netTool = NetworkTool(
        url: URL(string: "https://picsum.photos/v2/list")!) { data in
            try? JSONDecoder().decode([PhotoInfo].self, from: data)
        }
    
    var body: some View {
        NavigationView {
            if let photos = netTool.source {
                List(photos) { photo in
                    NavigationLink(photo.author, destination: PhotoView(photo.download_url))
                }
            } else {
                Text("Loading...")
                    .onAppear() {
                        self.netTool.load()
                    }
            }
        }
    }
}

struct PhotoView: View {
    
    @ObservedObject var netTool:NetworkTool<UIImage>
    
    init(_ url: URL) {
        netTool = NetworkTool(url: url, transform: {UIImage(data: $0)})
    }
    
    var body: some View {
        if let data = netTool.source {
            Image(uiImage: data)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Text("Loading...")
                .onAppear() {
                    self.netTool.load()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
