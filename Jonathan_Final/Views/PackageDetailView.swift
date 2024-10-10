//
//  PackageDetailScreen.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

struct PackageDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var packageManager: PackageManager
    @State var package: Package
    @State private var deliveryAddress: String
    @State private var carrier: CarrierType
    @State private var deliveryDate: Date
    @State private var status: Bool
    
    init(package: Package) {
        _package = State(initialValue: package)
        _deliveryAddress = State(initialValue: package.deliveryAddress)
        _carrier = State(initialValue: package.carrier)
        _deliveryDate = State(initialValue: package.deliveryDate)
        _status = State(initialValue: package.status == .delivered)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Package Details")) {
                Text("Package ID: \(package.packageID)")
                TextField("Delivery Address", text: $deliveryAddress)
                DatePicker("Delivery Date", selection: $deliveryDate, displayedComponents: .date)
                Picker("Carrier", selection: $carrier) {
                    ForEach(CarrierType.allCases) { carrier in
                        Text(carrier.rawValue).tag(carrier)
                    }
                }
                Toggle("Delivered", isOn: $status)
            }
            
            Button("Update Package") {
                updatePackage()
            }
            .disabled(deliveryAddress.isEmpty)
        }
        .navigationTitle("Package Details")
    }
    
    private func updatePackage() {
        package.deliveryAddress = deliveryAddress
        package.deliveryDate = deliveryDate
        package.carrier = carrier
        package.status = status ? .delivered : .inTransit
        packageManager.updatePackage(package)
        dismiss()
    }
}

#Preview {
    PackageDetailView(package: Package(
            packageID: "123456",
            deliveryAddress: "123 Main St",
            deliveryDate: Date(),
            carrier: CarrierType.FedEx,
            status: .inTransit
    )).environmentObject(PackageManager())
}

#Preview {
    PackageDetailView(package: Package(
        packageID: "654321",
        deliveryAddress: "",
        deliveryDate: Date(),
        carrier: .UPS,
        status: .delivered
    )).environmentObject(PackageManager())
}
