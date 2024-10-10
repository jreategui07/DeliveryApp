//
//  Package.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import Foundation

class Package: Codable, Identifiable {
    var id = UUID()
    var packageID: String
    var deliveryAddress: String
    var deliveryDate: Date
    var carrier: CarrierType
    var status: PackageStatus
    
    init(packageID: String, deliveryAddress: String, deliveryDate: Date, carrier: CarrierType, status: PackageStatus) {
        self.packageID = packageID
        self.deliveryAddress = deliveryAddress
        self.deliveryDate = deliveryDate
        self.carrier = carrier
        self.status = status
    }
}
