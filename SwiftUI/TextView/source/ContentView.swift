//
//  ContentView.swift
//  SwiftUITextView
//
//  Created by KITANO on 2020/05/04.
//  Copyright © 2020 kitano. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var text: String = ""
    @State private var isEditing: Bool = false
    @State private var version: Int = 0

    var body: some View {
        VStack(alignment: .center, spacing: 16) {

            Text("Hello, TextView!")

            HStack(alignment: .center, spacing: 8) {
                InputLamp(isEditing: self.$isEditing)
                    .frame(width: 16, height: 16)

                Text("Count: \(self.text.count)")
            }

            Text("Version: \(self.version)")

            TextView("Input text", text: self.$text)
                .onEvent(onChanged: {

                    self.isEditing = true

                    withAnimation(.linear(duration: 0.5)) {
                        self.isEditing = false
                    }

                }, onEnded: {
                    self.version += 1
                })
        }
        .padding(16)
    }
}

struct InputLamp: View {

    @Binding var isEditing: Bool

    var body: some View {
        Circle()
            .overlay(Circle().stroke(Color(UIColor(rgba: "e0e0e0")), lineWidth: 1))
            .foregroundColor(self.isEditing ? Color.red : Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
