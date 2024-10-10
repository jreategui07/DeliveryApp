//
//  PersistenceManager.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import Foundation

class PersistenceManager {
    private let userDefaults = UserDefaults.standard
    private let packageKey = "packageList"
    
    func savePackage(_ package: Package) {
        var packages = getAllPackages()
        packages.append(package)
        if let encoded = try? JSONEncoder().encode(packages) {
            userDefaults.set(encoded, forKey: packageKey)
        }
    }
    
    func getAllPackages() -> [Package] {
        if let savedData = userDefaults.data(forKey: packageKey),
           let decoded = try? JSONDecoder().decode([Package].self, from: savedData) {
            return decoded
        }
        return []
    }
    
    func deletePackage(withID id: UUID) {
        var packages = getAllPackages()
        packages.removeAll { $0.id == id }
        if let encoded = try? JSONEncoder().encode(packages) {
            userDefaults.set(encoded, forKey: packageKey)
        }
    }
    
    func updatePackage(_ package: Package) {
        var packages = getAllPackages()
        if let index = packages.firstIndex(where: { $0.id == package.id }) {
            packages[index] = package
            if let encoded = try? JSONEncoder().encode(packages) {
                userDefaults.set(encoded, forKey: packageKey)
            }
        }
    }
}
