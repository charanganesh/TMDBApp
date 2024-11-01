//
//  ContentView.swift
//  TMDbApp
//
//  Created by Charan Ganesh on 31/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = MovieListViewModel()
    @State var screenSize = ScreenSize()
    
    var body: some View {
        MovieListView()
            .environment(viewModel)
            .environment(screenSize)
            .task {
                await viewModel.fetchMovies()
            }
            .overlay {
                GeometryReader { proxy in
                    Color.clear.ignoresSafeArea()
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            }
            .onPreferenceChange(SizePreferenceKey.self) { value in
                screenSize.size = value
                print(screenSize.size.width)
            }
    }
}
struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

@Observable
class ScreenSize {
    var size: CGSize = .zero
}

#Preview {
    ContentView()
}
