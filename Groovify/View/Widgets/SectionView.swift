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
    var items: [String] // Items to display in the section
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title on top of the section
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        VStack {
                            /* Basic rectangle with the item name for now,
                             but we can replace this with an image or a custom view.
                            */
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                            Text(item)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
