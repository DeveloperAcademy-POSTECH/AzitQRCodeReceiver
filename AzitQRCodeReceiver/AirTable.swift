//
//  AirTable.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/02.
//

import Foundation

class Records {
	var morningRecords : [ReceiveRecord] = []
	var afternoonRecords : [ReceiveRecord] = []
	var mentorsopsRecords : [ReceiveRecord] = []
}

class AirTalbe {
	var records = Records()
	
	init() {
		getRecords()
	}
	
	func attendanceCheck(name : String, session : String) {
		var record = findRecordIndex(name: name, session: session)!
		
//		if record == nil{
//			print("데이터를 찾을 수 없습니다. Session 과 Name을 확인해주세요.")
//			return
//		}
		
		record.fields.출석여부 = true
		let dummy2 = UpdateRecord(id: record.id, fields: convertFieldReceiveToUpdate(receive: record.fields))
		let dummy = UpdateSurveyModel(records: [dummy2])
		
		let urlString = "https://api.airtable.com/v0/appmg3JSHTUSQZNP3/Table%201"
		let url = URL(string: urlString)!
		var request = URLRequest(url: url)
		request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "PATCH"
		
		let encoder = JSONEncoder()
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		formatter.string(from: Date())
		encoder.dateEncodingStrategy = .formatted(formatter)
		do {
			request.httpBody = try encoder.encode(dummy)
		} catch {
			print(error)
		}
		
		var resultData : UpdateSurveyModel? = nil
		let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
			if error != nil {
				print(error!)
				return
			}
			print(String(decoding: data!, as: UTF8.self))
			do {
				resultData = try JSONDecoder().decode(UpdateSurveyModel.self, from: data!)
			} catch let e as NSError {
				print(e.localizedDescription)
			}
		})
		
		dataTask.resume()
		
		while dataTask.state != .completed || resultData == nil {}
		
		print("\(resultData!.records[0].fields.Name)의 출석여부가 \(resultData!.records[0].fields.출석여부!)로 바뀌었습니다.")
		
		print(record.fields.출석여부)													// 다르다
		print(findRecordIndex(name: name, session: session)?.fields.출석여부)	// 다르다
	}
	
	private func findRecordIndex(name : String, session : String) -> ReceiveRecord? {
		switch session {
		case "Morning Session":
			return findIndexByName(self.records.morningRecords, name: name)
		case "Afternoon Session":
			return findIndexByName(self.records.afternoonRecords, name: name)
		case "Mentors / Ops":
			return findIndexByName(self.records.mentorsopsRecords, name: name)
		default:
			return nil
		}
	}
	
	private func findIndexByName(_ records : [ReceiveRecord], name : String) -> ReceiveRecord? {
		for index in 0..<records.count {
			if records[index].fields.Name == name {
				return records[index]
			}
		}
		return nil
	}
	
	

	
	func getRecords() {
		let urlFixString = "https://api.airtable.com/v0/appmg3JSHTUSQZNP3/Table%201?&view=Result%28All%29"
		var urlString : String
		var offset : String? = nil
		var resultData : ReceiveModel? = nil
		
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
					resultData = try JSONDecoder().decode(ReceiveModel.self, from: data!)
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
					self.records.morningRecords.append(ele)
				case "🌝 Afternoon Session":
					self.records.afternoonRecords.append(ele)
				case "Mentors / Ops":
					self.records.mentorsopsRecords.append(ele)
				default:
					print("분류되지 않은 SESSION이 있습니다.")
				}
			}
			
			offset = resultData!.offset
			resultData = nil
		} while offset != nil
	}
	
	
}
