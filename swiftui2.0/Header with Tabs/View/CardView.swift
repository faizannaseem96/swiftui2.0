//
//  CardView.swift
//  swiftui2.0
//
//  Created by Faizan  Naseem on 18/01/2021.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    var food: Food
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10, content: {
                Text(food.title)
                    .fontWeight(.bold)
                Text(food.description)
                    .font(.caption)
                    .lineLimit(3)
                Text(food.price)
                    .fontWeight(.bold)
            })
            Spacer(minLength: 10)
            Image(food.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 125, height: 125)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(food: foods[0])
    }
}
