//
//  UnAttendListView.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/06.
//

import SwiftUI

struct UnAttendListView: View {
	@Binding var airtalbe : AirTalbe
	@Binding var showSelf : Bool
	@State private var unattendMorning : Int = 0
	@State private var unattendAfternoon : Int = 0
	
	var body: some View {
		VStack {
			HStack {
				VStack {
					Text("Morning Session")
						.font(.largeTitle)
					Text("\(self.unattendMorning)")
						.font(.largeTitle)
					ScrollView {
						ForEach(airtalbe.records.morningRecords) { element in
							if element.fields.출석여부 == nil && element.fields.참가여부 ==  "네, 참가 가능합니다." {
								Text(element.fields.Name)
									.onAppear{
										self.unattendMorning += 1
									}
							}
						}
					}
				}// V
				
				Divider()
					.padding()
	
				
				VStack {
					Text("Afternoon Session")
						.font(.largeTitle)
					Text("\(self.unattendAfternoon)")
						.font(.largeTitle)
					ScrollView {
						ForEach(airtalbe.records.afternoonRecords) { element in
							if element.fields.출석여부 == nil && element.fields.참가여부 ==  "네, 참가 가능합니다." {
								Text(element.fields.Name)
									.onAppear {
										self.unattendAfternoon += 1
									}
							}
						}
					}
				}// V
			} // H
			Spacer()
			Button(action: {self.showSelf.toggle()}){
				Text("Close")
			}
		}
    } // Body
} // View

struct UnAttendListView_Previews: PreviewProvider {
    static var previews: some View {
		UnAttendListView(airtalbe: .constant(AirTalbe()), showSelf: .constant(true))
    }
}
