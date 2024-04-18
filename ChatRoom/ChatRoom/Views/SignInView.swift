//
//  SignInView.swift
//  ChatRoom
//
//  Created by Ashraful Islam on 4/18/24.
//

import SwiftUI

struct SignInView: View {
    
    func loginButton(_ text: String) -> some View {
        Text(text)
            .font(.title2.bold())
            .padding()
            .frame(width: 300)
            .foregroundStyle(.black)
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke()
                    .foregroundStyle(.black)
            )
    }
    
    var body: some View {
        VStack (spacing: 20){
            Image(systemName: "person.badge.key.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 128)
            VStack (spacing: 20) {
                Button {
                    print("Sign in with Apple")
                } label: {
                    loginButton("Sign in with Apple")
                }
                
                Button {
                    print("Sign in with Google")
                } label: {
                    loginButton("Sign in with Google")
                }
            }
        }
    }
}

#Preview {
    SignInView()
}
