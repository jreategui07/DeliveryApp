//
//  PackageDetailScreen.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

struct PackageDetailView: View {
    @EnvironmentObject var packageManager: PackageManager
    @State var package: Package
    @State private var deliveryAddress: String
    @State private var carrier: String
    @State private var deliveryDate: Date
    @State private var selectedCarrier: CarrierType = .FedEx
    @State private var status: Bool
    
    init(package: Package) {
        _package = State(initialValue: package)
        _deliveryAddress = State(initialValue: package.deliveryAddress)
        _carrier = State(initialValue: package.carrier.rawValue)
        _deliveryDate = State(initialValue: package.deliveryDate)
        _status = State(initialValue: package.status == "Delivered")
    }
    
    var body: some View {
        Form {
            Section(header: Text("Package Details")) {
                Text("Package ID: \(package.packageID)")
                TextField("Delivery Address", text: $deliveryAddress)
                DatePicker("Delivery Date", selection: $deliveryDate, displayedComponents: .date)
                Picker("Carrier", selection: $selectedCarrier) {
                    ForEach(CarrierType.allCases) { carrier in
                        Text(carrier.rawValue).tag(carrier)
                    }
                }
                Toggle("Delivered", isOn: $status)
            }
            
            Button("Update Package") {
                package.deliveryAddress = deliveryAddress
                package.deliveryDate = deliveryDate
                package.carrier = selectedCarrier
                package.status = status ? "Delivered" : "In Transit"
                packageManager.updatePackage(package)
            }
        }
        .navigationTitle("Package Details")
    }
}

#Preview {
    PackageDetailView(package: Package(
            packageID: "123456",
            deliveryAddress: "123 Main St",
            deliveryDate: Date(),
            carrier: CarrierType.FedEx,
            status: "In Transit"
    )).environmentObject(PackageManager())
}
