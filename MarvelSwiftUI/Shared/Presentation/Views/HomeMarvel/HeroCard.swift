import SwiftUI

struct HeroCard: View {
    let hero: Hero
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                // Background rectangle with rounded corners and shadow
                RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.2)).shadow(radius: 4).frame(height: 200)
                // Load and display the hero's thumbnail image
                if let url = URL(string: hero.thumbnailURL), !hero.thumbnailURL.isEmpty {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            // Show a loading indicator while the image is loading
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .gray)).frame(width: 50, height: 50).background(Color.gray.opacity(0.1)).clipShape(RoundedRectangle(cornerRadius: 16))
                        case .success(let image):
                            // Display the loaded image with specific styling
                            image
                                .resizable().scaledToFill().frame(width: UIScreen.main.bounds.width - 32, height: 200).clipped().opacity(0.8).clipShape(RoundedRectangle(cornerRadius: 16))
                        case .failure:
                            // Show a fallback image if loading fails
                            Image(.noimage)
                                .resizable().scaledToFit().frame(width: 50, height: 50).foregroundStyle(.gray).opacity(0.3).clipShape(RoundedRectangle(cornerRadius: 16))
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                // Display the hero's name at the bottom left corner
                Text(hero.name ?? "unknown")
                    .font(.headline).bold().foregroundStyle(.white).padding(8).background(Color.black.opacity(0.6)).clipShape(RoundedRectangle(cornerRadius: 8)).padding([.leading, .bottom], 16)
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 200)
        }
        .padding(.horizontal, 16) // Horizontal padding to prevent cards from touching screen edges
    }
}
#if DEBUG
struct HeroCard_Previews: PreviewProvider {
    static var previews: some View {
        HeroCard(hero: Hero(
            id: 1,
            name: "Spider-Man",
            thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/a/c0/66f2d68d99dc8", ext: "jpg")
        ))
        .previewLayout(.sizeThatFits)
    }
}
#endif
