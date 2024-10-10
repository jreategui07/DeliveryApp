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
    case inTransit = "In Transit"
    case delivered = "Delivered"
}

enum FilterOption: String, CaseIterable, Identifiable {
    case all = "All"
    case inTransit = "In Transit"
    case delivered = "Delivered"
    var id: String { self.rawValue }
}
