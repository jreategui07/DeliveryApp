//
//  enums.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

enum CarrierType: String, CaseIterable, Identifiable, Codable {
    case FedEx = "FedEx"
    case UPS = "UPS"
    case DHL = "DHL"
    var id: CarrierType { self }
}

enum PackageStatus: String, Codable {
    case delivered = "Delivered"
    case inTransit = "In Transit"
}
