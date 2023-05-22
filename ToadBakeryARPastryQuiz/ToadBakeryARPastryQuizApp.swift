//
//  ToadBakeryARPastryQuizApp.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 24/04/2023.
//

import SwiftUI

@main
struct ToadBakeryARPastryQuizApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(QuizManager())
        }
    }
}
