//
//  RatingView.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 02/11/24.
//

import SwiftUI

struct RatingView: View {
    let rating: Double // Rating out of 10
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<10) { index in
                starView(for: index)
            }
        }
    }
    
    private func starView(for index: Int) -> some View {
        let starType = starType(for: index)
        
        return Image(systemName: starType)
            .foregroundColor(.yellow)
            .font(.system(size: 16)) // Adjust size as needed
    }
    
    private func starType(for index: Int) -> String {
        let currentStarIndex = Double(index + 1)
        
        if rating >= currentStarIndex {
            return "star.fill" // Full star
        } else if rating >= currentStarIndex - 0.5 {
            return "star.leadinghalf.filled" // Half star
        } else {
            return "star" // Empty star
        }
    }
}
