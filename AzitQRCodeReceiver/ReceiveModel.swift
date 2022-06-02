//
//  SurveyModel.swift
//  AzitQRCodeReceiver
//
//  Created by Choi Inho on 2022/06/02.
//

import Foundation

struct ReceiveModel : Codable {
	var records : [ReceiveRecord]
	let offset : String?
}

struct ReceiveRecord : Codable {
	var fields : ReceiveField
	let id : String
	let createdTime : String
}

struct ReceiveField : Codable {
	var Name : String
	var Created : String
	var Session : String
	var 참가여부 : String
	var 티셔츠구매여부 : String?
	var 사이즈 : String?
	var 티셔츠약관 : Bool?
	var 불참이유 : String?
	var Ryver계정을알려주세요 : String?
	var 출석여부 : Bool?
}

struct UpdateSurveyModel : Codable {
	var records : [UpdateRecord]
}

struct UpdateRecord : Codable {
	let id : String
	let fields : UpdateField
}

struct UpdateField : Codable {
	var Name : String
	var Session : String
	var 참가여부 : String
	var 티셔츠구매여부 : String?
	var 사이즈 : String?
	var 티셔츠약관 : Bool?
	var 불참이유 : String?
	var Ryver계정을알려주세요 : String?
	var 출석여부 : Bool?
}

func convertFieldReceiveToUpdate(receive : ReceiveField) -> UpdateField{
	return UpdateField(Name: receive.Name, Session: receive.Session, 참가여부: receive.참가여부, 티셔츠구매여부: receive.티셔츠구매여부, 사이즈: receive.사이즈, 티셔츠약관: receive.티셔츠약관, 불참이유: receive.불참이유, Ryver계정을알려주세요: receive.Ryver계정을알려주세요, 출석여부: receive.출석여부)
}

func isSameName(record_name : String, qrcode_name : String) -> Bool {
	return record_name.components(separatedBy: "(")[0].lowercased() == qrcode_name.lowercased()
}
