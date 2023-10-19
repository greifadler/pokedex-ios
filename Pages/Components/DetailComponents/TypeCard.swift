//
//  TypeCardView.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct TypeCard: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack {
            Text(text)
                .font(
                    Font.custom("Rubik", size: 16)
                        .weight(.semibold)
                )
                .foregroundColor(Color(red: 0.05, green: 0.04, blue: 0.25))
                .padding(.horizontal, 14)
                .padding(.vertical, 4)
                .background(Color(red: 0.16, green: 0.98, blue: 0.79))
                .cornerRadius(99)
        }
    }
}
