//
//  ProjectoApp.swift
//  Projecto
//
//  Created by CCDM13 on 22/11/22.
//

import SwiftUI

@main
struct ProjectoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
