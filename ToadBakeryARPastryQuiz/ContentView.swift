//
//  ContentView.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 24/04/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var quizManager: QuizManager
    @State private var userName: String = ""
    @State private var shouldDismiss: Bool = false
    @State private var isQuizViewPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("toad logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 350)
                    .padding(.bottom, -70)
                
                VStack(spacing: 10) {
                    TextField("Enter your name", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)
                    
                    ToadButton(action: {
                        quizManager.resetQuiz()
                        isQuizViewPresented = true
                    }, label: "Start Quiz")
                    .padding(.top, 15)
                    .padding(.horizontal, 40)
                }
                
                NavigationLink(
                    destination: QuizView(userName: userName, shouldDismiss: $shouldDismiss),
                    isActive: $isQuizViewPresented,
                    label: { EmptyView() }
                )
            }
            .padding(.top, 80)
            .padding(.horizontal, 40)
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(QuizManager())
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
