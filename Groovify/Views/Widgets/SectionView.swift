//
//  SectionView.swift
//  Groovify
//
//  Created by Kunal Bajaj on 2024-11-12.
//

import SwiftUI

/**
 A view that displays a section with a title and a horizontal scroll view of items.
 Just like in spotify to display the categories, Top Charts, recommended, etc.
 */
struct SectionView: View {
    var title: String // Title of the section
    var items: [NewRelease] // Items to display in the section //
    
//    changed [String] to [NewRelease]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title on top of the section
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items) { item in //items, id: \.self
                        VStack(alignment: .leading)  {
                            /* Basic rectangle with the item name for now,
                             but we can replace this with an image or a custom view.
                            */
//                            Rectangle()
//                                .fill(Color.blue)
//                                .frame(width: 120, height: 120)
//                                .cornerRadius(10)
                            
                            if let imageUrl = item.images.first?.url {
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                }
                                .frame(width: 150, height: 150)
                                .cornerRadius(8)
                            }
                            
                            Text(item.name)
                                .font(.caption)
                                .lineLimit(1)
                                .frame(width: 150)
                                .foregroundColor(.white)
                            
                        }
                    }
//                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

//#Preview {
//    SectionView(title: "Top Charts", items: ["Song1", "Song2", "Song3", "Song4", "Song5"])
//}
#Preview {
  SectionView(title: "Top Charts", items: [
    NewRelease(album_type: "", id: "", name: "Song 1", images: [], release_date: "", href: ""),
    NewRelease(album_type: "", id: "", name: "Song 2", images: [], release_date: "", href: ""),
    
  ])
}
