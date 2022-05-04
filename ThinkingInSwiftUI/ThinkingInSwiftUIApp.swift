//
//  ThinkingInSwiftUIApp.swift
//  ThinkingInSwiftUI
//
//  Created by jeffy on 2022/5/3.
//

import SwiftUI

@main
struct ThinkingInSwiftUIApp: App {
    
    init() {
#if DEBUG
        var injectionBundlePath = "/Applications/InjectionIII.app/Contents/Resources"
        
#if targetEnvironment(macCatalyst)
        injectionBundlePath = "\(injectionBundlePath)/macOSInjection.bundle"
        
#elseif os(iOS)
        injectionBundlePath = "\(injectionBundlePath)/iOSInjection.bundle"
        
#endif
        Bundle(path: injectionBundlePath)?.load()
#endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
