import SwiftUI

struct PokemonCard: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink(destination: PokemonDetailPage(pokemon: pokemon)) {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 163, height: 163)
                        .background(
                            LazyImage(imageURL: URL(string: pokemon.imageUrl),
                                             imageSize: CGSize(width: 163, height: 163),
                                             backgroundColor: Color("BGGray"))
                        )
                    HStack {
                        HStack(alignment: .center, spacing: 10) {
                            Text(pokemon.id.formatPokedexNumber())
                                .font(
                                    Font.custom("Rubik", size: 10)
                                        .weight(.medium)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("DarkTextColor"))
                        }
                        .padding(.horizontal, 6)
                        .padding(.top, 4)
                        .padding(.bottom, 2)
                        .background(Color("AccentColor"))
                        .cornerRadius(4)
                    }
                    .padding(8)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(.white)
                .shadow(color: Color(red: 0.19, green: 0.22, blue: 0.45).opacity(0.15), radius: 7.5, x: 0, y: 2)
            }
            HStack(alignment: .center, spacing: 0) {
                Text(pokemon.name)
                    .font(
                        Font.custom("Rubik", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color("TextColor"))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                CardMenu(url: URL(string: pokemon.imageUrl)!, pokemon: pokemon)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("DarkTextColor"))
        }
        .frame(maxWidth: 163, maxHeight: .infinity)
        .background(Color("DarkTextColor"))
        .cornerRadius(8)
        .shadow(color: Color(red: 0.19, green: 0.22, blue: 0.45).opacity(0.15), radius: 7.5, x: 0, y: 2)
        .padding(8)
        
    }
}
