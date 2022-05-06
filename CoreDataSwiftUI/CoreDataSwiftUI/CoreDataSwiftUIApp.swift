//
//  CoreDataSwiftUIApp.swift
//  CoreDataSwiftUI
//
//  Created by Eugene G on 5/5/22.
//

import SwiftUI

@main
struct CoreDataSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
