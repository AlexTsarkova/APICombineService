//
//  BonusCardView.swift
//  APICombineService
//
//  Created by Александра on 29.04.2021.
//

import SwiftUI

public struct BonusCardView: View {
    var totalBonusCount: String
    var burnDate: String
    var burnBonuses: String
    var iconColor: Color
    var iconSize: CGFloat
    var titleFont: Font
    var bottomTextFont: Font
    
    public init(totalBonusCount: String,
                burnDate: String,
                burnBonuses: String,
                iconColor: Color = Color.red,
                iconSize: CGFloat = 34,
                titleFont: Font = Font.system(size: 24),
                bottomTextFont: Font = .callout) {
        self.totalBonusCount = totalBonusCount
        self.burnDate = burnDate
        self.burnBonuses = burnBonuses
        self.iconColor = iconColor
        self.iconSize = iconSize
        self.titleFont = titleFont
        self.bottomTextFont = bottomTextFont
    }
    
    
    public var body: some View {
        ZStack {
            CardView()
            
            
            HStack {
                CardText(
                    totalBonusCount: totalBonusCount,
                    burnDate: burnDate,
                    burnBonuses: burnBonuses,
                    titleFont: titleFont,
                    bottomTextFont: bottomTextFont)
                    .padding()
                
                Spacer()
                
                ChevronCircleIcon(iconColor: iconColor, iconSize: iconSize)
                    .padding()
            }
        }.frame(minWidth: minWidth, maxWidth: maxWidth, maxHeight: maxHeight, alignment: .center)
        .padding(.horizontal, 20)
    }
    
    //Drawing constants
    let minWidth: CGFloat = 335
    let maxWidth: CGFloat = 400
    let maxHeight: CGFloat = 105
}


public struct CardView: View {
    public  var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(Color.white)
            .shadow(color: Color.black.opacity(0.5), radius: 5)
    }
}

public struct CardText: View {
    var totalBonusCount: String
    var burnDate: String
    var burnBonuses: String
    var titleFont: Font
    var bottomTextFont: Font
    
    public init(totalBonusCount: String,
                burnDate: String,
                burnBonuses: String,
                titleFont: Font,
                bottomTextFont: Font) {
        self.totalBonusCount = totalBonusCount
        self.burnDate = burnDate
        self.burnBonuses = burnBonuses
        self.titleFont = titleFont
        self.bottomTextFont = bottomTextFont
    }
    
    
    public  var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("\(totalBonusCount) бонусов")
                .foregroundColor(.black)
                .font(titleFont)
                .bold()
            HStack {
                Text("\(burnDate) сгорит")
                Image("fire")
                    .frame(width: 13, height: 17, alignment: .center)
                Text("\(burnBonuses) бонусов")
            }.font(bottomTextFont)
            .foregroundColor(.gray)
        }
    }
}

public struct ChevronCircleIcon: View {
    var iconColor: Color
    var iconSize: CGFloat
    
    public init(iconColor: Color,
                iconSize: CGFloat) {
        self.iconColor = iconColor
        self.iconSize = iconSize
    }
    
    public var body: some View {
        Image(systemName: "chevron.right.circle")
            .font(
                .system(size: iconSize,
                        weight: .thin))
            .foregroundColor(iconColor)
    }
}

