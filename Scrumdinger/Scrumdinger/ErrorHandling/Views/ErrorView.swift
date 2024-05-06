//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Ashraful Islam on 5/5/24.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occured!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 16))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }

    }
}

struct ErrorView_Previews: PreviewProvider {
    enum sampleError: Error {
        case errorRequired
    }

    static var wrapper: ErrorWrapper {
        ErrorWrapper(
            error: sampleError.errorRequired, guidance: "You can safely ignore this error.")
    }

    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }

}
