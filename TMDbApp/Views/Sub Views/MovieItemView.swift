//
//  MovieItemView.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import SwiftUI
//import SDWebImageSwiftUI

struct MovieItemView: View {
    let movie: Movie
    let runtime: Int?
    @Environment(ScreenSize.self) var screenSize

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = BaseURL.imageURL(path: movie.posterPath, size: .w500) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    .frame(height: 270)
                }
                /*
                WebImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                 */
            }
            
            VStack(alignment: .leading, spacing: 4) {
                MarqueeText(text: movie.title, font: UIFont.preferredFont(forTextStyle: .headline), leftFade: 16, rightFade: 16, startDelay: 2)
                    .foregroundStyle(.white)
                
                if let runtime {
                    Text("Duration: \(runtime) mins")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                HStack {
                    Text("⭐️ \(movie.voteAverage, specifier: "%.1f")")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    Text("(\(movie.voteCount) votes)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color.black.opacity(0.6))
        }
//        .frame(maxWidth: screenSize.size.width / 2 - 20)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
