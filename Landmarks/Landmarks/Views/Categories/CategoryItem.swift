//
//  CategoryItem.swift
//  Landmarks
//
//  Created by Ashraful Islam on 2/12/24.
//

import SwiftUI

struct CategoryItem: View {
    var landmark: Landmark
    
    var body: some View {
        
        VStack(alignment: .leading) {
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Text(landmark.name)
                .foregroundStyle(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

#Preview {
    CategoryItem(landmark: ModelData().landmarks[0])
}
