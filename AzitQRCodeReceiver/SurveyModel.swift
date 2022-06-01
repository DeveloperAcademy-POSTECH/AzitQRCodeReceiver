//
//  SurveyModel.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/02.
//

import Foundation

struct SurveyModel : Codable {
	let records : [Record]
	let offset : String?
}

struct Record : Codable {
	let fields : Fields
	let id : String
	let createdTime : String
}

struct Fields : Codable {
	let Name : String
	let Created : String
	let Session : String
	let 참가여부 : String
	let 티셔츠구매여부 : String?
	let 사이즈 : String?
	let 티셔츠약관 : Bool?
	let 불참이유 : String?
	let Ryver계정을알려주세요 : String?
	let 출석여부 : String?
}

class AirTalbe {
	var morningRecords : [Record] = []
	var afternoonRecords : [Record] = []
	var mentorsopsRecords : [Record] = []
	
	func attendanceCheck(name : String, session : String) {
		let record = findRecord(name: name, session: session)
		
		if record == nil{
			print("데이터를 찾을 수 없습니다. Session 과 Name을 확인해주세요.")
			return
		}
		
		
	}
	
	private func findRecord(name : String, session : String) -> Record? {
		switch session {
		case "Morning Session":
			return findByName(morningRecords, name: name)
		case "Afternoon Session":
			return findByName(afternoonRecords, name: name)
		case "Mentors / Ops":
			return findByName(mentorsopsRecords, name: name)
		default:
			return nil
		}
	}
	
	private func findByName(_ records : [Record], name : String) -> Record? {
		for record in records {
			if record.fields.Name == name {
				return record
			}
		}
		return nil
	}
	

	
	func getRecords() {
		let urlFixString = "https://api.airtable.com/v0/appmg3JSHTUSQZNP3/Table%201?&view=Result%28All%29"
		var urlString : String
		var offset : String? = nil
		var resultData : SurveyModel? = nil
		
		repeat {
			if offset == nil {
				urlString = urlFixString
			}
			else{
				urlString = urlFixString + "&offset=" + offset!
			}
			
			let url = URL(string: urlString)!
			var request = URLRequest(url: url)
			request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
			request.setValue("itrY5pGFxuZhQJlKu/rec5nHXCPV9nU2vgc", forHTTPHeaderField: "o")
			
			let dataload = URLSession.shared.dataTask(with: request) { data, response, error in
				if error != nil {
					print(error!)
					return
				}
				do {
//					print(String(decoding: data!, as: UTF8.self))
					resultData = try JSONDecoder().decode(SurveyModel.self, from: data!)
//					print(resultData?.records)
				} catch let e as NSError {
					print(e.localizedDescription)
				}
			}
			
			dataload.resume()
			
			while dataload.state != .completed || resultData == nil {}
			
//			print(resultData!.records[0].fields.Name)
//			print(resultData!.records.count)
			
			for ele in resultData!.records {
				switch ele.fields.Session {
				case "🌞 Morning Session":
					morningRecords.append(ele)
				case "🌝 Afternoon Session":
					afternoonRecords.append(ele)
				case "Mentors / Ops":
					mentorsopsRecords.append(ele)
				default:
					print("분류되지 않은 SESSION이 있습니다.")
				}
			}
			
			offset = resultData!.offset
			resultData = nil
		} while offset != nil
		
		print(morningRecords.count + afternoonRecords.count + mentorsopsRecords.count)
	}
}
