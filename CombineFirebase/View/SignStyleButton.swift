//
//  SignStyleButton.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 29.05.21.
//

import SwiftUI

struct SignStyleButton: ButtonStyle {
    var colorBG: Color
    var colorText: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: 50)
            .font(.title2)
            .foregroundColor(colorText)
            .background(Capsule().fill(colorBG))
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .padding()
    }
}

struct SignStyleButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}, label: {
            Text("Example")
        })
        .preferredColorScheme(.dark)
        .buttonStyle(SignStyleButton(colorBG: .white, colorText: .orangeGradientEnd))
    }
}
