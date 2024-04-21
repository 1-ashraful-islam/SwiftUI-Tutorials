//
//  ReminderToggleStyle.swift
//  MakeItSo-ReminderClone
//
//  Created by Ashraful Islam on 4/21/24.
//

import SwiftUI

struct ReminderToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(configuration.isOn ? Color.accentColor : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

extension ToggleStyle where Self == ReminderToggleStyle {
    static var reminder: ReminderToggleStyle {
        ReminderToggleStyle()
    }
}

#Preview {
    struct Container: View {
        @State var isOn = false
        var body: some View {
            Toggle(isOn: $isOn) { Text("Hello") }
                .toggleStyle(.reminder)
        }
    }

    return Container()
}
