//
//  ContentView.swift
//  MacLandmarks
//
//  Created by Ashraful Islam on 2/13/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
            .frame(minWidth: 700, minHeight: 300)
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
