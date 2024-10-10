//
//  PackageManager.swift
//  Jonathan_Final
//
//  Created by Jonathan Reátegui on 2024-10-10.
//

import Foundation

class PackageManager: ObservableObject {
    @Published var packages: [Package] = []
    
    private let persistenceManager = PersistenceManager()

    init() {
        packages = persistenceManager.getAllPackages()
    }
    
    func addPackage(_ package: Package) {
        packages.append(package)
        persistenceManager.savePackage(package)
    }
    
    func deletePackage(at offsets: IndexSet) {
        offsets.forEach { index in
            let packageID = packages[index].id
            persistenceManager.deletePackage(withID: packageID)
        }
        packages.remove(atOffsets: offsets)
    }
    
    func updatePackage(_ package: Package) {
        if let index = packages.firstIndex(where: { $0.id == package.id }) {
            packages[index] = package
            persistenceManager.updatePackage(package)
        }
    }
}
