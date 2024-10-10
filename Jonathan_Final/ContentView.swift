//
//  ContentView.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /**
         ContentView can handles initial logic or validations before displaying PackageListView, keeping separation of concerns
         */
        PackageListView()
    }
}

#Preview {
    ContentView().environmentObject(PackageManager())
}
