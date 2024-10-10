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
                Group {
                    if packageManager.packages.isEmpty {
                        Text("No packages to display.")
                            .font(.headline)
                            .foregroundColor(.gray)
                    } else {
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
                    }
                }
                .navigationBarTitle("Package List App")
                .navigationBarItems(trailing: NavigationLink(
                        "Add Package",
                        destination: NewPackageView()
                ))
            }
        }
}

#Preview {
    // to simulate when there is not any package
    PackageListView().environmentObject(PackageManager())
}

#Preview {
    // to simulate when there are packages in storage
    let previewPackageManager = PackageManager()
    previewPackageManager.packages = [
        Package(
            packageID: "123456",
            deliveryAddress: "123 Main St",
            deliveryDate: Date(),
            carrier: .FedEx,
            status: "In Transit"
        ),
        Package(
            packageID: "654321",
            deliveryAddress: "456 Oak St",
            deliveryDate: Date(),
            carrier: .UPS,
            status: "Delivered"
        )
    ]
    return PackageListView().environmentObject(previewPackageManager)
}
