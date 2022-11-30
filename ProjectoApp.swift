//
//  ProjectoApp.swift
//  Projecto
//
//  Created by CCDM13 on 22/11/22.
//

import SwiftUI

@main
struct ProjectApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager() )

        }
    }
}
