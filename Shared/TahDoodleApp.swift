//
//  TahDoodleApp.swift
//  Shared
//
//  Created by Andrei Korikov on 28.06.2021.
//

import SwiftUI

@main
struct TahDoodleApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            ContentView(taskStore: TaskStore())
                .frame(minWidth: 200,
                       maxWidth: 300,
                       minHeight: 200)
            #else
            ContentView(taskStore: TaskStore())
            #endif
        }
    }
}
