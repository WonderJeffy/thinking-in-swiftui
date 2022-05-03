//
//  NetworkTool.swift
//
//
//  Created by jeffy on 2022/5/2.
//

import SwiftUI

/// 用于请求失败时 .failure 参数需要一个遵守 Error 协议对象
struct LoadingError: Error {}


/// 请求数据的类
final class NetworkTool<T>: ObservableObject {
    
    /// @Published 在result 的值变化时通知接收者更新
    @Published var result:Result<T, Error>? = nil
    
    /// 重写 get 方法, 只有在 result==.success 的时候返回值
    var source: T? {
        try? result?.get()
    }
    
    /// 请求地址
    let url: URL
    /// 处理数据的回调闭包
    let transform:(Data)->T?
    
    init(url: URL, transform: @escaping(Data)->T?) {
        self.url = url
        self.transform = transform
    }
    
    /// 请求数据的方法
    func load() -> Void {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            // SwiftUI 中修改值应放在主线程
            DispatchQueue.main.async {
                if let d = data, let t = self.transform(d) {
                    self.result = .success(t)
                } else {
                    self.result = .failure(LoadingError())
                }
            }
        }.resume()
    }
}
