//
//  CanvasView.swift
//  WWDC21SwifUI
//
//  Created by Milos Malovic on 10.6.21..
//

import SwiftUI

@available(iOS 15.0, *)
struct CanvasView: View {

    @State private var play = false

    var body: some View {
        VStack {
            if play {
                TimelineView(.animation) { timeline in
                    Canvas { context, size in
                        let now = timeline.date.timeIntervalSinceReferenceDate
                        let angle = Angle.degrees(now.remainder(dividingBy: 3) * 120)
                        let x = cos(angle.radians)
                        var image = context.resolve(Image(systemName: "hourglass"))
                        image.shading = .color(.purple)
                        let imageSize = image.size
                        context.blendMode = .screen
                        for i in 0...10 {
                            let frame = CGRect(x: 0.5 * size.width + Double(i) * imageSize.width * x, y: 0.5 * size.height, width: imageSize.width, height: imageSize.height)
                            var innerContext = context
                            innerContext.opacity = 0.6
                            innerContext.fill(Ellipse().path(in: frame), with: .color(.purple))
                            context.draw(image, in: frame)
                        }
                    }
                }
                .frame(width: 160, height: 100)
            }
            Button("Play") {
                play.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
}

@available(iOS 15.0, *)
struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
            .preferredColorScheme(.dark)
    }
}
