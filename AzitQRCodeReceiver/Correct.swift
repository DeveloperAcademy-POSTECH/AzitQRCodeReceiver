//
//  Test.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/05.
//

import SwiftUI

struct Correct: View {
	@State var attempts: Int = 0

	var body: some View {
		VStack {
			Rectangle()
				.fill(Color.pink)
				.frame(width: 200, height: 100)
				.modifier(Shake(animatableData: CGFloat(attempts)))
			Spacer()
			Button(action: {
				withAnimation(.default) {
					self.attempts += 1
				}
			

			}, label: { Text("Login") })
		}
	}
}


struct Correct_Previews: PreviewProvider {
    static var previews: some View {
        Correct()
    }
}


struct Shake: GeometryEffect {
	var amount: CGFloat = 10
	var shakesPerUnit = 3
	var animatableData: CGFloat

	func effectValue(size: CGSize) -> ProjectionTransform {
		ProjectionTransform(CGAffineTransform(translationX:
			amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
			y: 0))
	}
}

//struct Wrong: View {
//	@State var wrongAttempt: Bool = false
//
//	   var body: some View {
//		   VStack {
//			Rectangle()
//				.fill(Color.pink)
//				.frame(width: 200, height: 100)
//				.offset(x: wrongAttempt ? -10 : 0)
//				.animation(Animation.default.repeatCount(5))
//			   Spacer()
//			   Button(action: { self.wrongAttempt.toggle() }, label: { Text("Login") })
//		   }
//	   }
//}
