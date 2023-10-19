//
//  InfoSegmentButton.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct SegmentButton: View {
    let title: String
    let tab: Details.Tab
    @Binding var selectedTab: Details.Tab
    
    var body: some View {
        VStack {
            Text(title)
                .font(
                    Font.custom("Rubik", size: 14)
                        .weight(selectedTab == tab ? .semibold : .regular)
                )
                .foregroundColor(selectedTab == tab ? Color("TextColor") : Color("DisabledTextColor"))
            
            Rectangle()
                .frame(maxWidth: .infinity, minHeight: 2, maxHeight: 2)
                .foregroundColor(selectedTab == tab ? Color("AccentColor") : Color("DisabledTextColor"))
                .padding(.top, 2) // Add spacing between text and line
            
        }
        .background(Color.clear)
        .onTapGesture {
            selectedTab = tab
        }
    }
}
