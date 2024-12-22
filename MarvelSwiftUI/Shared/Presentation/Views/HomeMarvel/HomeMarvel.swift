import SwiftUI

struct HomeMarvel: View {
    @Environment(AppStateVM.self) var appState // Access the application state from the environment
    
    var body: some View {
        NavigationStack { // Navigate between views
            VStack(alignment: .center, spacing: 0) {
                // Marvel logo at the top
                Image(.marvelLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .accessibilityLabel("Marvel Logo")
                
                // Featured series banner
                ZStack(alignment: .bottomLeading) {
                    Image(.newSeries)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .opacity(0.8)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 5)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    
                    // Overlay text on the featured series
                    Text("upcomingDisney2025")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                }.frame(maxWidth: .infinity, alignment: .center)
                Spacer().frame(height: 16) // Space between banner and heroes list
                // Section title for heroes
                Text("marvelHeroes")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 16)
                // List of Marvel heroes
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(appState.heroes) { hero in
                            NavigationLink(destination: {
                                if let id = hero.id {
                                    SeriesMarvel()
                                        .environment(SeriesViewModel(heroID: id))
                                } else {
                                    Text("noValidHeroID")
                                }
                            }) {
                                HeroCard(hero: hero)
                                    .padding(.horizontal, 16) // Padding for each hero card
                            }
                        }
                    }.padding(.vertical, 16)
                }.background(Color.clear) // Transparent background for the scroll view
                 .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand to fill available space
            }
            .edgesIgnoringSafeArea(.top) // Extend view to the top edge
            .background(Color(.systemBackground)) // Adapt to light/dark mode
        }
    }
}

#Preview {
    HomeMarvel()
        .environment(AppStateVM()) // Provide environment for preview
}
