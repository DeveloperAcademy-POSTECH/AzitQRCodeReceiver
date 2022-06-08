//
//  ListElementView.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/05.
//

import SwiftUI

struct ListElementView: View {
	@State var isFirst : Bool
	@State  var element : UpdateRecord
	private let firstBackgroundColor = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
	private let normalBackgroundColor = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
	
	var body: some View {
		ZStack {
			Rectangle()
				.foregroundColor(.clear)
				.background(isFirst ? firstBackgroundColor : normalBackgroundColor)
				.cornerRadius(16)
			
			VStack {
				Text(getNickname(element.fields.Name))
					.font(.largeTitle)
					.foregroundColor(.white)
				Text(element.fields.Session)
					.font(.title2)
					.foregroundColor(.white)
			}
		}
		.frame(height: 100)
	}
	
}

struct ListElementView_Previews: PreviewProvider {
    static var previews: some View {
		ListElementView(isFirst: true, element: UpdateRecord(id: "", fields: UpdateField(Name: "Toby", Session: "Afternoon Session", 참가여부: "네 참가합니다.", 티셔츠구매여부: "네 구매합니다.", 사이즈: "3Xl", 티셔츠약관: true, 불참이유: nil, Ryver계정을알려주세요: "", 출석여부: true, 티셔츠수령여부: "수령함", 입금: true)))
    }
}
