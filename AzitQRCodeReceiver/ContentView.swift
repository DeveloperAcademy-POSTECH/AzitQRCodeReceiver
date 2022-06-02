//
//  ContentView.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/05/31.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
	private let airtable = AirTalbe()
	@State var session : String = ""
	@State var name : String = ""
	
    var body: some View {
		VStack {
			CodeScannerView(codeTypes: [.qr],scanMode: .oncePerCode, videoCaptureDevice: .default(for: .video)) { response in
				switch response {
				case .success(let result):
					print("Found code: \(result.string)")
					let arrayResult = result.string.components(separatedBy: ",")
				
					self.session = arrayResult[0].trimmingCharacters(in: .whitespaces)
					self.name = arrayResult[1].trimmingCharacters(in: .whitespaces)
					airtable.attendanceCheck(name: self.name, session: self.session)
					
				case .failure(let error):
					print(error.localizedDescription)
				}
			}// CodeScannerView
			
			Group {
				Text("Name : \(name)")
					.padding()
				Text("Session : \(session)")
					.padding()
			} // Group
			
		}// VStack
    } // body
} // Struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
