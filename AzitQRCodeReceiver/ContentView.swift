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
				airtable.getRecords()
			}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
