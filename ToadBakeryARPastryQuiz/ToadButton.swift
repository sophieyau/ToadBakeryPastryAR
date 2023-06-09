//
//  ToadButton.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 25/05/2023.
//

import SwiftUI

struct ToadButton: View {
    var action: () -> Void
    var label: String
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: action) {
                HStack {
                    Spacer()
                    
                    Text(label)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity) // Expand the width to fill available space
                        .background(Color(hex: "3C5221")) // Set the background color of the button
                        .cornerRadius(10)
                        .fixedSize(horizontal: false, vertical: true) // Allow dynamic height
                    
                    Spacer()
                }
            }
            .overlay(
                Circle()
                    .frame(width: 37, height: 37) // Set the size of the circle
                    .foregroundColor(Color(hex: "3C5221")) // Set the color of the circle
                    .offset(x: -geometry.size.width / 2 + 25, y: -30) // Position top-left circle
            )
            .overlay(
                Circle()
                    .frame(width: 37, height: 37) // Set the size of the circle
                    .foregroundColor(Color(hex: "3C5221")) // Set the color of the circle
                    .offset(x: geometry.size.width / 2 - 25, y: -30) // Position top-right circle
            )
            .padding(.horizontal, 15) // Adjust horizontal padding
        }
    }
}
