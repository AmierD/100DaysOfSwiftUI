//
//  RatingView.swift
//  Bookworm
//
//  Created by Amier Davis on 2/3/26.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    
    var maxRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1...maxRating, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    @Previewable @State var rating = 3
    RatingView(rating: $rating)
}
