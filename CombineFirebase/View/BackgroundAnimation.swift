//
//  BackgroundAnimation.swift
//  SwiftUI_Firebase
//
//  Created by Валерий Игнатьев on 29.05.21.
//

import SwiftUI

struct BackgroundAnimation: View {
    @State private var startAnimation: Bool = false
    private var width = UIScreen.main.bounds.width
    private var height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
//            ForEach(20...100, id: \.self) { _ in
                ForEach(3...7, id: \.self) { _ in
                    Circle()
                    .fill(Color.red).opacity(.random(in: 0.3...0.4))
                    .frame(width: .random(in: 120...420), height: .random(in: 120...420))
                    .position(x: startAnimation ? .random(in: 0...width) : .random(in: 0...width),
                              y: startAnimation ? .random(in: 0...height) : .random(in: 0...height))
                    .animation(.linear(duration: 50).repeatCount(100, autoreverses: true))
            }
        }
        .onAppear {
            startAnimation.toggle()
        }
    }
}

struct BackgroundAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundAnimation()
    }
}
