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
                TextField("Enter your name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    isQuizViewPresented = true
                    quizManager.resetQuiz()
                }) {
                    Text("Start Quiz")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(userName.isEmpty)

                NavigationLink(
                    destination: QuizView(userName: userName, shouldDismiss: $shouldDismiss),
                    isActive: $isQuizViewPresented,
                    label: { EmptyView() })
            }
            .padding()
            .navigationTitle("Toad Bakery")
        }
        .onReceive(Just(shouldDismiss)) { dismissed in
                    if dismissed {
                        userName = "" // Clear user's name
                        isQuizViewPresented = false
                    }
                }
                .environmentObject(QuizManager())
            }
        }
