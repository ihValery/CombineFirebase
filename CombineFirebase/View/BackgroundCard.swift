//
//  BackgroundCard.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 28.05.21.
//

import SwiftUI

struct BackgroundCard: View {
    var height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(Color.white).opacity(0.6)
                .frame(height: height)
                .offset(y: 20.0)
                .padding(.horizontal, 30)
            
            RoundedRectangle(cornerRadius: 7)
                .fill(Color.white).opacity(0.6)
                .frame(height: height)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                .offset(y: 10.0)
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

struct Line: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 2)
            .opacity(0.6)
    }
}