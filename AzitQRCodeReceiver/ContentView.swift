//
//  ContentView.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/05/31.
//

import SwiftUI
import CodeScanner
import AVFoundation

struct ContentView: View {
	@State var airtable = AirTalbe()
	@State var attendeesList : [UpdateRecord] = []
	@State var attendeesCount : Int = 0
	@State var attendessRecent : UpdateRecord? = nil
	@State var attendessLearner : Int = 0
	@State var participateLearner : Int = 0
	@State var showUnattend : Bool = false
	@State var unknown : Bool = false
	@State var unknownPerson : UnknownPerson = UnknownPerson(name: "", session: "")
	@State var shakeInt : Int = 0
	private let screenWidth = UIScreen.main.bounds.width
	private let screenHeight = UIScreen.main.bounds.height
	
	
    var body: some View {
		HStack{
			ZStack(alignment: .top) {
				CodeScannerView(codeTypes: [.qr],scanMode: .oncePerCode, videoCaptureDevice: .default(for: .video)) { response in
					switch response {
					case .success(let result):
						print("Found code: \(result.string)")
						let arrayResult = result.string.components(separatedBy: ",")
					
						let session = arrayResult[0].trimmingCharacters(in: .whitespaces)
						let name = arrayResult[1].trimmingCharacters(in: .whitespaces)
						self.attendessRecent = airtable.attendanceCheck(name: name, session: session)
						//TODO: 정보 갖고와서 티셔츠 구매 여부 알려주기
						if self.attendessRecent == nil {
							self.unknownPerson.name = name
							self.unknownPerson.session = session
							
							SoundSetting.instance.playSound(.wrong)
							
							self.unknown.toggle()
							break
						}
						
						attendeesList.append(self.attendessRecent!)
						self.participateLearner += 1
						self.attendessLearner += 1
						
						SoundSetting.instance.playSound(.correct)
						
					case .failure(let error):
						print(error.localizedDescription)
					}
				}// CodeScannerView
				
				if self.unknown {
					UnknownPersonView(person: self.$unknownPerson)
						.frame(height: 240)
						.onAppear {
							Timer.scheduledTimer(withTimeInterval : 5, repeats: false) { timer in
								self.unknown.toggle()
							}
							withAnimation(.default) {
								self.shakeInt += 1
							}
						}
						.modifier(Shake(animatableData: CGFloat(self.shakeInt)))
						.padding()
				}
				else if attendessRecent != nil {
					PopUpView(attendessRecent: self.$attendessRecent)
						.frame(height: 240)
						.onAppear {
							Timer.scheduledTimer(withTimeInterval : 2, repeats: false) { timer in
								self.attendessRecent = nil
							}
							withAnimation(.default) {
								self.shakeInt += 1
							}
						}
						.modifier(Shake(animatableData: CGFloat(self.shakeInt)))
						.padding()
				}
				
			}// ZStack
			VStack {
				
				List {
					ForEach(attendeesList.reversed()) { element in
						if attendeesList.last?.id == element.id {
							ListElementView(isFirst: true, element: element)
								.onAppear {
									withAnimation(.default) {
										self.shakeInt += 1
									}
								}
								.modifier(Shake(animatableData: CGFloat(self.shakeInt)))
						} else {
							ListElementView(isFirst: false, element: element)
						}
					} //ForEach
				} // List
				
				Spacer()
				HStack {
					Button(action: {self.showUnattend.toggle()}) {
						Text("Show unattendees")
					}.sheet(isPresented: self.$showUnattend){
						UnAttendListView(airtalbe: self.$airtable, showSelf: self.$showUnattend)
					}
					
					Button(action: {
						airtable.getRecords()
						self.participateLearner = airtable.participantLearner
						self.attendessLearner = airtable.attendeesLearner
					}) {
						Text("Recheck Attendees")
					}
				}
			} // VStack Page2
			.frame(width: 450)
		}// HStack
		
	} // body
} // Struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
