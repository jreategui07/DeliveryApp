//
//  NewPackageScreen.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import SwiftUI

struct NewPackageView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var packageManager: PackageManager
    @State private var packageID = ""
    @State private var deliveryAddress = ""
    @State private var deliveryDate = Date()
    @State private var selectedCarrier: CarrierType = .FedEx
    @State private var status = false
    @State private var showErrorMessage: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Package Details")) {
                TextField("Package ID", text: $packageID)
                    .keyboardType(.numberPad)
                    .onChange(of: packageID) { _ in
                        showErrorMessage = !isPackageIdValid()
                    }
                
                TextField("Delivery Address", text: $deliveryAddress)
                DatePicker("Delivery Date", 
                           selection: $deliveryDate,
                           in: Date.now...,
                           displayedComponents: .date
                )
                Picker("Carrier", selection: $selectedCarrier) {
                    ForEach(CarrierType.allCases) { carrier in
                        Text(carrier.rawValue).tag(carrier)
                    }
                }
                Toggle("Delivered", isOn: $status)
                // to display an error message is the package is not valid (only numbers)
                if showErrorMessage {
                    Text("Invalid Package ID. Please enter only numbers.")
                        .foregroundColor(.red)
                }
            }
            
            Button("Save Package") {
                savePackage()
            }
            .disabled(
                packageID.isEmpty ||
                deliveryAddress.isEmpty ||
                !isPackageIdValid()
            )
        }
        .navigationTitle("New Package")
    }
    
    private func savePackage() {
        if !isPackageIdValid() {
            return
        }
        let newPackage = Package(
            packageID: packageID,
            deliveryAddress: deliveryAddress,
            deliveryDate: deliveryDate,
            carrier: selectedCarrier,
            status: status ? .delivered : .inTransit
        )
        packageManager.addPackage(newPackage)
        dismiss()
    }
    
    private func isPackageIdValid() -> Bool {
        // packageID shold be a string of numbers
        return packageID.allSatisfy { $0.isNumber }
    }
}

#Preview {
    NewPackageView().environmentObject(PackageManager())
}
