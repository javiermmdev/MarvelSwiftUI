import SwiftUI

struct SeriesCard: View {
    
    let serie: MarvelSeries
    
    // Computed property to provide a default description if none is available
    var descriptionText: String {
        if let description = serie.description, !description.isEmpty {
            return description
        } else {
            return "-"
        }
    }
    
    // Computed property to provide a default rating if none is available
    var ratingText: String {
        if let rating = serie.rating, !rating.isEmpty {
            return rating
        } else {
            return "-"
        }
    }
    
    // Computed property to provide a default type if none is available
    var typeText: String {
        if let type = serie.type, !type.isEmpty {
            return type
        } else {
            return "-"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Thumbnail image section
            ZStack {
                if let urlString = "\(serie.thumbnail.path).\(serie.thumbnail.extension)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                   let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            // Display a loading indicator while the image is being fetched
                            ProgressView()
                                .frame(height: 100)
                                .frame(maxWidth: .infinity)
                        case .success(let image):
                            // Display the fetched image with appropriate styling
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 100)
                                .clipped()
                        case .failure:
                            // Show a fallback image if the image fails to load
                            Image(.noimage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    // Show a fallback image if the URL is invalid
                    Image(.noimage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Section with a light gray background occupying full width
            VStack(alignment: .leading, spacing: 8) {
                // Series title
                Text(serie.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                
                // Series description
                Text(descriptionText)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .lineLimit(3)
                
                // Emission years
                Text("\(serie.startYear) - \(serie.endYear)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // Series rating
                Text("Rating: \(ratingText)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // Button aligned to the right
                HStack {
                    Spacer()
                    Button(action: {
                        // Define button action here
                    }) {
                        Text(typeText)
                            .font(.caption)
                            .foregroundStyle(.blue)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                }
                .padding([.top], 8)
                .padding([.trailing, .bottom], 8)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 16)
    }
}

#Preview {
    SeriesCard(serie: MarvelSeries(
        id: 6381,
        title: "Ender's Shadow: Battle School (2008 - 2009)",
        description: "A strategic battle school scenario featuring Ender Wiggin.",
        startYear: 2008,
        endYear: 2009,
        rating: "5 Stars",
        type: "Action",
        thumbnail: MarvelSeries.Thumbnail(
            path: "https://i.annihil.us/u/prod/marvel/i/mg/c/10/4bb64aaaa9755",
            extension: "jpg"
        )
    ))
}
