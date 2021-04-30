//
//  Token.swift
//
//  Created by Александра on 28.04.2021.
//

import Foundation

struct Token: Codable {
  struct Result: Codable {
    let status: Int
    let message: String?
    let messageDev: String?
    let codeResult: Int
    let duration: Double
    let idLog: String
  }
    let result: Result
    let accessToken: String?
}
