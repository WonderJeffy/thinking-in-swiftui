//
//  Chapter2View.swift
//  Chapter2-Exercise
//
//  Created by jeffy on 2022/5/2.
//

import SwiftUI

/// 遵守 Codable 协议, 属性名与 json 中的 key 需要对应
struct PhotoInfo: Codable, Identifiable {
    var id: String
    var author: String
    var width, height: Double
    var url, download_url: URL
}

struct Chapter2View: View {
    @ObservedObject var netTool = NetworkTool(
        url: URL(string: "https://picsum.photos/v2/list")!) { data in
            try? JSONDecoder().decode([PhotoInfo].self, from: data)
        }
    
    var body: some View {
        NavigationView {
            Group {
                if let photos = netTool.source {
                    List(photos) { photo in
                        NavigationLink(photo.author, destination: PhotoView(photo.download_url))
                    }
                    
                } else {
                    Text("Loading...")
                        .onAppear() { self.netTool.load() }
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
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

struct Chapter2View_Previews: PreviewProvider {
    static var previews: some View {
        Chapter2View()
    }
}
