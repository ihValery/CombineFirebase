//
//  SignSelectButton.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 29.05.21.
//

import SwiftUI

struct SignSelectButton: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.title2)
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 3)
                .padding(.horizontal, 5)
        }
        .foregroundColor(.white)
    }
}

struct SignSelectButton_Previews: PreviewProvider {
    static var previews: some View {
        SignSelectButton(text: "Test")
    }
}
