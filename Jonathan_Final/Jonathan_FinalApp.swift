//
//  Jonathan_FinalApp.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

@main
struct Jonathan_FinalApp: App {
    @StateObject private var packageManager = PackageManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(packageManager)
        }
    }
}
