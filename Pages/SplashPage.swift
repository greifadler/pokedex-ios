//
//  SplashPage.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct SplashPage: View {
    var body: some View {
        ZStack {
            Color("BGColored").edgesIgnoringSafeArea(.all)
            Image("PokemonLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
        }
    }
}

#Preview {
    SplashPage()
}
