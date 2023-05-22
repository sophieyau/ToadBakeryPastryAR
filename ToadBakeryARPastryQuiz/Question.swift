//
//  Question.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 24/04/2023.
//

import Foundation

struct Question: Identifiable, Decodable {
    let id = UUID()
    let text: String
    let options: [String]
    let scores: [Double]
}
