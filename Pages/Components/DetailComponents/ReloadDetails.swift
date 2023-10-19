//
//  ReloadDetails.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//


import SwiftUI

struct ReloadDetails: View {

    var reloadAction: () -> Void // Define a function parameter

    var body: some View {
        VStack {
            Text("Error while loading your Pokemon!")
                .font(.headline)
                .padding()
            
            Button(action: {
                // Call the reloadAction function when the button is tapped
                reloadAction()
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.title)
                    Text("Reload")
                        .font(.headline)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        
        }
    }
}
}
