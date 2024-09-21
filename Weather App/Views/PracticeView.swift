//
//  PracticeView.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/21/24.
//

import SwiftUI

struct PracticeView: View {
    @ObservedObject var locationSearchService: LocationSearchService

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $locationSearchService.searchQuery)
                List(locationSearchService.completions) { completion in
                    VStack(alignment: .leading) {
                        VStack {
                            Text(completion.title)
                            Text(completion.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            print(completion.title)
                            print(completion.subtitle)
                        }
                    }
                }.navigationBarTitle(Text("Search near me"))
            }
        }
    }
}
