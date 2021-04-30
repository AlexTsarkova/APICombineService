//
//  ClientBonusInfo.swift
//
//  Created by Александра on 29.04.2021.
//

import Foundation

struct ClientBonusInfo: Codable {
  struct ResultOperation: Codable {
    let status: Int
    let message: String?
    let messageDev: String?
    let codeResult: Int
    let duration: Double
    let idLog: String
  }

  struct Data: Codable {
    let typeBonusName: String?
    let currentQuantity: Double
    let forBurningQuantity: Double
    let dateBurning: String
  }

  let resultOperation: ResultOperation
  let data: Data
}
