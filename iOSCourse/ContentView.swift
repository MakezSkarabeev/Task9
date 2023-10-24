//
//  ContentView.swift
//  iOSCourse
//
//  Created by Sivenkov maxim  on 01.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var dragValue: CGSize = .zero

    var body: some View {
        Canvas { context, size in
            let firstCircle = context.resolveSymbol(id: 0)!
            let secondCircle = context.resolveSymbol(id: 1)!
            let width = size.width / 2
            let height = size.height / 2

            context.addFilter(.alphaThreshold(min: 0.5, color: .blue))
            context.addFilter(.blur(radius: 30))

            context.drawLayer {
                $0.draw(firstCircle, at: .init(x: width, y: height))
                $0.draw(secondCircle, at: .init(x: width, y: height))
            }
        } symbols: {
            Circle()
                .fill(.blue)
                .frame(width: 100, height: 100, alignment: .center)
                .tag(0)

            Circle()
                .fill(.blue)
                .frame(width: 100, height: 100, alignment: .center)
                .offset(x: dragValue.width, y: dragValue.height)
                .tag(1)
        }
        .gesture(DragGesture()
            .onChanged({ value in
                dragValue = value.translation
            })
            .onEnded({ value in
                dragValue = .zero
            })
        )
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: self.dragValue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
