//
//  RotatedBadgeSymbol.swift
//  Landmarks
//
//  Created by Ashraful Islam on 2/12/24.
//

import SwiftUI

struct RotatedBadgeSymbol: View {
    let angle: Angle

    var body: some View {
        BadgeSymbol()
            .padding(-60)
            .rotationEffect(angle, anchor: .bottom)
    }
}

#Preview {
    Group {
        RotatedBadgeSymbol(angle: Angle(degrees: 5))
        RotatedBadgeSymbol(angle: Angle(degrees: 35))
    }
}
