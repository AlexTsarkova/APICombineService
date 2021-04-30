//
//  Client.swift
//
//  Created by Александра on 28.04.2021.
//

import Foundation


struct Client: Codable {
  let idClient: String?
  let accessToken: String
  let paramName: String
  let paramValue: String?
  let latitude: Float
  let longitude: Float
  let sourceQuery: Int
}
