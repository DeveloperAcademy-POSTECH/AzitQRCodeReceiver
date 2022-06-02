//
//  ContentView.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/05/31.
//

import SwiftUI

struct ContentView: View {
	private let airtable = AirTalbe()
	
    var body: some View {
        Text("Hello, world!")
            .padding()
			.onAppear {
				print(airtable.afternoonRecords.count)
				airtable.attendanceCheck(name: "Toby(최인호)", session: "Afternoon Session")
			}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
