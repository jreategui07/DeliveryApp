//
//  PackageListScreen.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

struct PackageListView: View {
    @EnvironmentObject var packageManager: PackageManager
    
    var body: some View {
            NavigationView {
                List {
                    ForEach(packageManager.packages) { package in
                        NavigationLink(destination: PackageDetailView(package: package)) {
                            VStack(alignment: .leading) {
                                Text("Package ID: \(package.packageID)")
                                Text("Delivery Date: \(package.deliveryDate, style: .date)")
                                Text("Status: \(package.status)")
                            }
                        }
                    }
                    .onDelete(perform: packageManager.deletePackage)
                }
                .navigationBarTitle("Your Name")
                .navigationBarItems(trailing: NavigationLink(
                        "Add Package",
                        destination: NewPackageView()
                ))
            }
        }
}

#Preview {
    PackageListView().environmentObject(PackageManager())
}
