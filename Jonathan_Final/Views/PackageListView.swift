//
//  PackageListScreen.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

struct PackageListView: View {
    @EnvironmentObject var packageManager: PackageManager
    @State private var selectedFilter: FilterOption = .all
    
    var filteredPackages: [Package] {
        switch selectedFilter {
        case .all:
            return packageManager.packages
        case .delivered:
            return packageManager.packages.filter { $0.status == .delivered }
        case .inTransit:
            return packageManager.packages.filter { $0.status == .inTransit }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Filter status", selection: $selectedFilter) {
                    ForEach(FilterOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    ForEach(filteredPackages) { package in
                        NavigationLink(destination: PackageDetailView(package: package)) {
                            VStack(alignment: .leading) {
                                Text("Package ID: \(package.packageID)")
                                Text("Delivery Date: \(package.deliveryDate, style: .date)")
                                Text("Status: \(package.status.rawValue)")
                            }
                        }
                    }
                    .onDelete(perform: packageManager.deletePackage)
                }
                .overlay(
                    // to display a message when there is not packages to display
                    filteredPackages.isEmpty ?
                    Text("No packages to display.")
                        .font(.headline)
                        .foregroundColor(.gray)
                    : nil
                )
            }
            .navigationBarTitle("Jonathan")
            .navigationBarItems(trailing: NavigationLink(
                    "New Package",
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
            status: .inTransit
        ),
        Package(
            packageID: "654321",
            deliveryAddress: "456 Oak St",
            deliveryDate: Date(),
            carrier: .UPS,
            status: .delivered
        )
    ]
    return PackageListView().environmentObject(previewPackageManager)
}
