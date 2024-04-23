//
//  AuthenticationView.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/22/24.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var viewModel = AuthenticationViewModel()

    var body: some View {
        VStack {
            switch viewModel.flow {
            case .login:
                LoginView()
                    .environmentObject(viewModel)
            case .signUp:
                SignupView()
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    AuthenticationView()

}
