//
//  APIIProBonus.swift
//
//  Created by Александра on 28.04.2021.
//

import Foundation

public class APIIProBonus: ObservableObject {
    @Published var token: String?
    @Published var clientBonusInfo: ClientBonusInfo?
    public var clientTotalBonus: Double?
    public var clientBonusBirned: Double?
    public var birnData: String?
    public var clientID: String
    public var deviceID: String
    
   public struct AppError: Identifiable {
        public let id = UUID().uuidString
        let errorString: String
    }
    
   public init(clientID: String, deviceID: String) {
        self.clientID = clientID
        self.deviceID = deviceID
        getToken(clientID: self.clientID, deviceID: self.deviceID)
    }
    

    
   public func getToken(clientID: String, deviceID: String) {
        let apiService = APIGetToken.shared
        apiService.getJSON(urlString: "https://mp1.iprobonus.com/api/v3/clients/accesstoken/",
                           idClient: clientID,
                           paramValue: deviceID)
        { (result: Result<Token,APIGetToken.APIError>) in
            
            switch result {
            case .success(let tokenFromService):
                DispatchQueue.main.async {
                    self.token = tokenFromService.accessToken
                    DispatchQueue.global().async {
                        self.getBonusInfo()
                    }
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                    
                }
            }
        }
    }
    
   public func getBonusInfo() {
        let apiService = APIGetClientInfo.shared
        if token != nil {
            apiService.getJSON(urlString: "https://mp1.iprobonus.com/api/v3/ibonus/generalinfo/\(token!)") { (result: Result<ClientBonusInfo,APIGetClientInfo.APIError>) in
            
            switch result {
            case .success(let bonusInfo):
                DispatchQueue.main.async {
                    self.clientBonusInfo = bonusInfo
                    self.clientTotalBonus = bonusInfo.data.currentQuantity
                    self.clientBonusBirned = bonusInfo.data.forBurningQuantity
                    
                    let isoDate = bonusInfo.data.dateBurning

                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "ru_RU")
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    let date = dateFormatter.date(from:isoDate)!
                    
                    let calendar = Calendar.current
                    let day = calendar.component(.day, from: date)
                    let month = calendar.component(.month, from: date)
                    let dateBurn = String(day) + "." + String(month)
                    
                    self.birnData = dateBurn
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                    
                }
            }
        }
        } else {
            print("The token did not come from the server")
        }
    }
}
