//
//  ContentView.swift
//  APICombineService
//
//  Created by Александра on 28.04.2021.
//

import SwiftUI
import CoreLocation
import Foundation
import BonusCardView
import APIIProBonus

struct ContentView: View {
    @StateObject var API = APIIProBonus(clientID: "2c44d8c2-c89a-472e-aab3-9a8a29142315",
                                        deviceID: "7db72635-fd0a-46b9-813b-1627e3aa02ea")
    
    var iconsColor = Color(#colorLiteral(red: 0.9155445695, green: 0.2626399994, blue: 0.3068207502, alpha: 1))
    
    var body: some View {
        VStack {
            HStack {
                Text("ЛОГОТИП")
                Spacer()
                Image("iconI")
                    .font(
                        .system(
                            size: 24,
                            weight: .regular).italic())
                    .foregroundColor(iconsColor)
            }.padding(20)
            
            ZStack {
                RedRectangle(iconsColor: iconsColor)
                .offset(y: 70)
            BonusCardView(
                totalBonusCount: String(format: "%d", API.clientTotalBonus ?? "?"),
                burnDate: API.birnData ?? "01.01",
                burnBonuses: String(format: "%d", API.clientBonusBirned ?? "?"),
                iconColor: iconsColor,
                iconSize: 34,
                titleFont: .system(size: 24))

            }.offset(y: -20)
            Spacer()
        }
        
    }
}

struct RedRectangle: View {
    var iconsColor: Color
    
    var body: some View {
        Rectangle()
            .frame(maxWidth: nil, maxHeight: 148, alignment: .center)
            .foregroundColor(iconsColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
