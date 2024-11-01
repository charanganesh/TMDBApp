//
//  MovieDetailView.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @State var detailViewModel = MovieDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                if !detailViewModel.isLoading {
                    VStack {
                        posterAndDetails
                        VStack(alignment: .leading) {
                            trailerSection
                            plotSection
                            castSection
                        }
                        .padding()
                    }
                }
            }
            .ignoresSafeArea()
            dismissButton
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await detailViewModel.fetchDetails(for: movie.id)
        }
    }
    
    // MARK: - Poster and Details Section
    private var posterAndDetails: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: BaseURL.imageURL(path: movie.posterPath, size: .w500)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(detailViewModel.movieDetail?.originalTitle ?? "Title not available")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.bottom, 4)
                
                HStack {
                    Text(" \(detailViewModel.movieDetail?.voteAverage ?? 0, specifier: "%.1f")")
                        .foregroundStyle(.yellow)
                    RatingView(rating: detailViewModel.movieDetail?.voteAverage ?? 0)
                    Text("(\(detailViewModel.movieDetail?.voteCount ?? 0) votes)")
                        .foregroundColor(.white)
                }
                .font(.subheadline)
                
                if let runtime = detailViewModel.movieDetail?.runtime {
                    Text("Duration: \(runtime) minutes")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
                if let genres = detailViewModel.movieDetail?.genres {
                    Text("Genres: \(genres.map { $0.name }.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding([.top, .bottom])
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.6))
        }
    }
    
    // MARK: - Trailer Section
    private var trailerSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Trailer")
                .font(.headline)
                .padding(.top)
            YouTubePlayerWebView(videoId: detailViewModel.movieTrailer?.results.first(where: { $0.typeEnum == .trailer })?.key ?? "")
                .frame(height: 240)
                .cornerRadius(10)
        }
    }
    
    // MARK: - Plot Section
    private var plotSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Plot")
                .font(.headline)
                .padding(.top)
            
            Text(detailViewModel.movieDetail?.overview ?? "No overview available.")
                .font(.body)
                .padding(.bottom, 8)
        }
    }
    
    // MARK: - Cast Section
    private var castSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Cast")
                .font(.headline)
                .padding(.top)
            
            if detailViewModel.mainCast.isEmpty {
                Text("Cast information is currently unavailable.")
                    .font(.body)
                    .foregroundColor(.secondary)
            } else {
                ForEach(detailViewModel.mainCast, id: \.id) { castMember in
                    HStack(alignment: .top) {
                        if let profilePath = castMember.profilePath,
                           let imageURL = BaseURL.imageURL(path: profilePath, size: .w200) {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 75)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 50, height: 75)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(castMember.name)
                                .font(.subheadline)
                                .bold()
                            
                            if let character = castMember.character {
                                Text("as \(character)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.leading, 8)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
    
    private var dismissButton: some View {
        HStack {
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(uiColor: .label))
                    .background(.regularMaterial)
                    .clipShape(Circle())
            }
        }
        .padding(.top, 10)
        .padding(.trailing, 20)
    }
}

