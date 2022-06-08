//
//  UnknownPersonView.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/06.
//

import SwiftUI

struct UnknownPersonView: View {
	@Binding var person : UnknownPerson
	var body: some View {
		ZStack {
			HStack {
				Text("WRONG | ")
					.font(.largeTitle)
				Text(self.person.name)
					.foregroundColor(.white)
					.font(.largeTitle)
					.padding()
				Text(self.person.session)
					.foregroundColor(.white)
					.font(.largeTitle)
					.padding()
			}
			.padding()
			.background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
			.cornerRadius(16)
		}
	}
}

struct UnknownPersonView_Previews: PreviewProvider {
    static var previews: some View {
		UnknownPersonView(person: .constant(UnknownPerson(name: "Toby", session: "Afternoon")))
    }
}
