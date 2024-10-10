//
//  NewPackageScreen.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

struct NewPackageView: View {
    @EnvironmentObject var packageManager: PackageManager
    @State private var packageID = ""
    @State private var deliveryAddress = ""
    @State private var deliveryDate = Date()
    @State private var carrier = "FedEx"
    @State private var status = false
    
    private let carriers = ["FedEx", "UPS", "DHL"]
    
    var body: some View {
        Form {
            Section(header: Text("Package Details")) {
                TextField("Package ID", text: $packageID)
                TextField("Delivery Address", text: $deliveryAddress)
                DatePicker("Delivery Date", selection: $deliveryDate, displayedComponents: .date)
                Picker("Carrier", selection: $carrier) {
                    ForEach(carriers, id: \.self) {
                        Text($0)
                    }
                }
                Toggle("Delivered", isOn: $status)
            }
            
            Button("Save Package") {
                let newPackage = Package(packageID: packageID, deliveryAddress: deliveryAddress, deliveryDate: deliveryDate, carrier: carrier, status: status ? "Delivered" : "In Transit")
                packageManager.addPackage(newPackage)
            }
        }
        .navigationTitle("New Package")
    }
}

#Preview {
    NewPackageView().environmentObject(PackageManager())
}
