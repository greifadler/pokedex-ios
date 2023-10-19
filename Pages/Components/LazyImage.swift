//
//  PokemonImageView.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct LazyImage: View {
    let imageURL: URL?
    let imageSize: CGSize
    let backgroundColor: Color
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                Image(systemName: "loading") // Placeholder until image loads
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "xmark.circle") // If the image fails to load
            @unknown default:
                Image(systemName: "questionmark.circle") // For future cases
            }
        }
        .frame(width: imageSize.width, height: imageSize.height)
        .background(backgroundColor)
    }
    
    
}
