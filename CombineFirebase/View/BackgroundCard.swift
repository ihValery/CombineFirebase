//
//  BackgroundCard.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 28.05.21.
//

import SwiftUI

struct BackgroundCard: View {
    @ObservedObject private var signViewModel = SignViewModel.shared
    var height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(Color.white).opacity(0.6)
                .overlay(
                    VStack {
                          Spacer()
                        Text(signViewModel.messageError)
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .padding(.bottom, 10)
                    })
                .frame(height: height)
                .offset(y: signViewModel.messageError.isEmpty ? 20 : 50)
                .padding(.horizontal, 30)
            
            RoundedRectangle(cornerRadius: 7)
                .fill(Color.white).opacity(0.6)
                .frame(height: height)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                .offset(y: 10)
                .padding(.horizontal, 15)
            
            RoundedRectangle(cornerRadius: 7)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                .frame(height: height)
        }
        .padding(.horizontal)
    }
}

struct BackgroundCard_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCard(height: 450)
    }
}
