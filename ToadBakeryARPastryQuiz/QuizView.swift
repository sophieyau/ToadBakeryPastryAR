//
//  QuizView.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 24/04/2023.
//

import SwiftUI

struct QuizView: View {
    let userName: String
    @EnvironmentObject private var quizManager: QuizManager
    @Binding var shouldDismiss: Bool
    
    
    var body: some View {
        VStack {
            if let question = quizManager.currentQuestion {
                Text(question.text)
                    .font(.title2)
                    .padding()
                
                ForEach(0..<question.options.count, id: \.self) { index in
                    Button(action: {
                        quizManager.answerQuestion(at: index)
                    }) {
                        Text(question.options[index])
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
            } else if quizManager.showResult {
                ResultView(userName: userName, pastry: quizManager.finalResult).onDisappear {
                    shouldDismiss = true
                }
            } else {
                Text("Loading...")
            }
        }
        .padding()
        .navigationTitle("Hi, \(userName)!")
        .onAppear(perform: {
            quizManager.loadQuiz()
        })
    }
}
