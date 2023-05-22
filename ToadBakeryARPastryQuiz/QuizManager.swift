//
//  QuizManager.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 24/04/2023.
//

import Foundation

class QuizManager: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestion: Question?
    @Published var showResult: Bool = false
    var finalResult: Pastry = Pastry.example
    
    private var answerCounts: [Int: Int] = [:]
    
    init() {
        loadQuiz()
    }
    
    
    func loadQuiz() {
        if let url = Bundle.main.url(forResource: "Questions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.questions = try decoder.decode([Question].self, from: data)
                self.currentQuestion = questions.first
                print("Quiz data loaded successfully")
            } catch {
                print("Error loading quiz data: \(error)")
            }
        } else {
            print("Error: Questions.json file not found")
        }
    }

    
    func answerQuestion(at index: Int) {
        answerCounts[index, default: 0] += 1
        
        if let currentIndex = questions.firstIndex(where: { $0.id == currentQuestion?.id }) {
            if currentIndex + 1 < questions.count {
                self.currentQuestion = questions[currentIndex + 1]
            } else {
                calculateResult()
                currentQuestion = nil
            }
        } else {
            print("Error: Current question not found in the list")
        }
    }
    func loadPastry(id: Int) -> Pastry? {
        if let pastry = Pastry.all.first(where: { $0.id == id }) {
            return pastry
        } else {
            return nil
        }
    }
    
    func resetQuiz() {
        answerCounts = [:]
        showResult = false
        currentQuestion = questions.first
    }
    
    
    
    private func calculateResult() {
        let firstQuestionAnswer = answerCounts[0] ?? 0
        
        // Filter pastries based on the first question's answer
        let filteredPastries: [Pastry]
        switch firstQuestionAnswer {
        case 1: // Vegetarian
            filteredPastries = Pastry.all.filter { $0.id != 4 } // Exclude Mambow Steak
        case 2: // Vegan
            finalResult = Pastry.all.first(where: { $0.id == 1 })! // Only Soy Sauce Chocolate Chip Cookie
            showResult = true
            return
        default:
            filteredPastries = Pastry.all
        }
        
        // Calculate total score
        var totalScore = 0.0
        for (index, score) in answerCounts where index > 0 {
            totalScore += Double(score)
        }
        
        // Assigning the pastry result based on score
        if totalScore >= 17 {
            finalResult = filteredPastries.first(where: { $0.id == 4 })!
        } else if totalScore >= 12 {
            finalResult = filteredPastries.first(where: { $0.id == 3 })!
        } else if totalScore >= 8 {
            finalResult = filteredPastries.first(where: { $0.id == 2 })!
        } else if totalScore >= 4 {
            finalResult = filteredPastries.first(where: { $0.id == 1 })!
        } else {
            finalResult = filteredPastries.first(where: { $0.id == 0 })!
        }
        showResult = true
    }
}
