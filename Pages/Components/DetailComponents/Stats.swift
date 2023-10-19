//
//  Stats.swift
//  student721009
//
//  Created by hohe on 18.10.23.
//

import SwiftUI

struct Stats: View {
    let details: PokemonDetailsResponse
    
    
    
    var body: some View {
        ForEach(details.stats, id: \.self.stat.name) { stat in
            StatsRow(statName: stat.stat.name.uppercased(), baseStat: stat.baseStat, effort: stat.effort)
        }
    }
    
}


struct StatsRow: View {
    let statName: String
    let baseStat: Int
    let effort: Int
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(statName)
                    .font(
                        Font.custom("Rubik", size: 14)
                            .weight(.semibold)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Text("\(baseStat)")
                    .font(Font.custom("Rubik", size: 14))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color("DisabledTextColor"))
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color("BGGray"))
                    .frame(maxWidth: .infinity, minHeight: 4, maxHeight: 4)
                    .cornerRadius(99)
                
                Rectangle()
                    .foregroundColor(Color("AccentColor"))
                    .frame(width: CGFloat(baseStat), height: 4)
                    .cornerRadius(99)
            }
            
            Spacer()
                .frame(height: 24)
        }
        .padding(.horizontal, 16)
    }
}





