//
//  VisitorModel.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/05.
//

import Foundation

struct Attendees : Identifiable {
	let id = UUID()
	var name : String
	var session : session
}

enum session : String {
	case morning = "Morning Session"
	case afternoon = "Afternoon Session"
}
