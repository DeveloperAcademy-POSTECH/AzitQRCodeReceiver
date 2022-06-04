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
	@State var attendeesList : [Attendees] = []
	
	private let screenWidth = UIScreen.main.bounds.width
	private let screenHeight = UIScreen.main.bounds.height
	
    var body: some View {
		HStack{
			VStack {
				CodeScannerView(codeTypes: [.qr],scanMode: .oncePerCode, videoCaptureDevice: .default(for: .video)) { response in
					switch response {
					case .success(let result):
						print("Found code: \(result.string)")
						let arrayResult = result.string.components(separatedBy: ",")
					
						self.session = arrayResult[0].trimmingCharacters(in: .whitespaces)
						self.name = arrayResult[1].trimmingCharacters(in: .whitespaces)
						airtable.attendanceCheck(name: self.name, session: self.session)
						//TODO: 정보 갖고와서 티셔츠 구매 여부 알려주기
						
					case .failure(let error):
						print(error.localizedDescription)
					}
				}// CodeScannerView
//				.dynamicTypeSize(.xLarge)
//				.frame(minWidth: 982, minHeight: 982)
				
				
//				Group {
//					Text("Name : \(name)")
//						.padding()
//					Text("Session : \(session)")
//						.padding()
//				} // Group
				
			}// VStack
			
			List {
				ForEach(attendeesList) { element in
					Text(element.name)
				}
			}
			
		}// HStack
		
		
		
    } // body
} // Struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
