//
//  PopUpView.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/05.
//

import SwiftUI

struct PopUpView: View {
	@Binding var attendessRecent : UpdateRecord?
	
    var body: some View {
		if self.attendessRecent != nil {
			ZStack {
				HStack {
					Text("WELCOME! ")
						.font(.largeTitle)
						.padding()
					Text(attendessRecent!.fields.Name)
						.foregroundColor(.white)
						.font(.largeTitle)
						.padding()
					Text(attendessRecent!.fields.Session)
						.foregroundColor(.white)
						.font(.largeTitle)
						.padding()
				}
				.background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
				.cornerRadius(16)
			}
		}
	}
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
		PopUpView(attendessRecent: .constant(UpdateRecord(id: "", fields: UpdateField(Name: "Toby", Session: "Afterrnoon", 참가여부: "네, 참가하겠습니다.", 티셔츠구매여부: "네 구매하겠습니다.", 사이즈: "3XL", 티셔츠약관: true, 불참이유: nil, Ryver계정을알려주세요: nil, 출석여부: true, 티셔츠수령여부: "네", 입금: true))))
    }
}
