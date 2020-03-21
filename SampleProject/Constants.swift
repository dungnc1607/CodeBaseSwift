//
//  Constants.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import Foundation
import UIKit
import DeviceKit
import RxSwift

public struct Constants {

    public struct UI {
        
        public static let screenBounds = UIScreen.main.bounds
        public static let screenWidth = screenBounds.width
        public static let screenHeight = screenBounds.height
        public static let baseDeviceWidth: CGFloat = 360.0 // base on Sketch file
        public static let baseDeviceHeight: CGFloat = 640.0
        public static let displayScale: CGFloat = screenWidth / baseDeviceWidth
        public static let displayScaleHeight: CGFloat = screenHeight / baseDeviceWidth
        
        public static let cornerRadius: CGFloat = 10.0 * displayScale
        public static let cornerRadiusThin: CGFloat = 5.0 * Constants.UI.displayScale
        public static let padding: CGFloat = 20.0 * displayScale
        public static let paddingThin: CGFloat = 8.0 * displayScale
        public static let paddingButtonBackground: CGFloat = 30.0 * displayScale
        public static let paddingBorderTextField: CGFloat = 24.0 * displayScale
        public static let buttonHeight: CGFloat = 50.0 * displayScale
        public static let buttonHorizontalHeight: CGFloat = 27.0 * displayScale
        public static let buttonHorizontalWidth: CGFloat = 75.0 * displayScale
        public static let buttonBoxWidth: CGFloat = 80.0 * displayScale
        public static let textFieldHeight: CGFloat = 40.0 * displayScale
        public static let labelHeight: CGFloat = 32.0 * displayScale
        public static let selectionTextFieldWidth: CGFloat = 90.0 * displayScale
        public static let formTitleLabelWidth: CGFloat = 100.0 * displayScale
        public static let cellHeight: CGFloat = 50.0 * displayScale
        public static let cellPadding: CGFloat = 5.0 * displayScale
        public static let lineHeight: CGFloat = 1.0 * displayScale
        public static let dotSize: CGFloat = 10.0 * displayScale
        public static let iconSize: CGFloat = 22.0 * displayScale
        public static let pickerLabelHeight: CGFloat = 70 * 2 * Constants.UI.displayScale
        
        public static func getSafeAreaTopPadding() -> CGFloat {
            guard #available(iOS 11.0, *) else { return 0 }
            let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
            return topPadding > 20 ? topPadding : 0
        }
        
        public static func getSafeAreaBottomPadding() -> CGFloat {
            guard #available(iOS 11.0, *) else { return 0 }
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottomPadding
        }
        
        public static func getSafeAreaTotalPadding() -> CGFloat {
            guard #available(iOS 11.0, *) else { return 0 }
            return getSafeAreaTopPadding() + getSafeAreaBottomPadding()
        }
    }

    public struct Theme {
        
        enum NavigationTheme {
            case transparent
            case colored
            case transparentColored
            case transparentOpacity
        }
    }

    public struct Color {
        public static let textLightColor = UIColor.init(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1.0)
        public static let appColor = UIColor.init(red: 242/255.0, green: 101/255.0, blue: 53/255.0, alpha: 1.0)
        public static let backgroundColor = UIColor.init(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1.0)
        public static let blackColor = UIColor.init(red: 81/255.0, green: 81/255.0, blue: 81/255.0, alpha: 1.0)
        public static let overlayColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        public static let textColor = UIColor.init(red: 72/255.0, green: 72/255.0, blue: 72/255.0, alpha: 1.0)
        public static let lineColor = UIColor.init(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1.0)
        public static let errorColor = UIColor.init(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0)
        public static let borderColor = UIColor.init(red: 192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 1.0)
        public static let buttonColor = UIColor.init(red: 0/255.0, green: 117/255.0, blue: 255/255.0, alpha: 1.0)
    }

    public struct Font {
        
        public static let fontScale: CGFloat = UI.displayScale
        public static let fontExtraTiny: UIFont = UIFont.init(name: "PingFangHK-Regular", size: 12 * fontScale)!
        public static let fontExtraTinyBold: UIFont = UIFont.init(name: "PingFangHK-Medium", size: 12 * fontScale)!
        public static let fontTiny: UIFont = UIFont.init(name: "PingFangHK-Regular", size: 14 * fontScale)!
        public static let fontTinyBold: UIFont = UIFont.init(name: "PingFangHK-Medium", size: 14 * fontScale)!
        public static let fontSmall: UIFont = UIFont.init(name: "PingFangHK-Regular", size: 16 * fontScale)!
        public static let fontSmallThin: UIFont = UIFont.init(name: "PingFangHK-Thin", size: 16 * fontScale)!
        public static let fontSmallBold: UIFont = UIFont.init(name: "PingFangHK-Medium", size: 16 * fontScale)!
        public static let fontMedium: UIFont = UIFont.init(name: "PingFangHK-Regular", size: 18 * fontScale)!
        public static let fontMediumBold: UIFont = UIFont.init(name: "PingFangHK-Medium", size: 18 * fontScale)!
        public static let font: UIFont = UIFont.init(name: "PingFangHK-Regular", size: 20 * fontScale)!
        public static let fontBold: UIFont = UIFont.init(name: "PingFangHK-Medium", size: 20 * fontScale)!
        public static let fontLarge: UIFont = UIFont.init(name: "PingFangHK-Regular", size: 22 * fontScale)!
        public static let fontLargeBold: UIFont = UIFont.init(name: "PingFangHK-Medium", size: 22 * fontScale)!
        public static let fontSupperLarge: UIFont = UIFont.init(name: "PingFangHK-Regular", size: 25 * fontScale)!
    }
    
    public struct Timer {
        
        public static let animationDuration: Double = 0.3
        public static let flashDuration: Double = 3.0
        public static let delayDuration: RxTimeInterval = .microseconds(1000)
        public static let throttle: RxTimeInterval = .microseconds(500)
        public static let rxAnimationDuration: RxTimeInterval = .microseconds(300)
    }

    public struct ImageName {
        public static let iconHome: String = "icon_home"
        public static let navigation: String = "bg_top"
        public static let storeNavigation: String = "bg_nav_store"
        public static let iconBack: String = "icon_back"
        public static let iconClose: String = "icon_close"
    }

    public struct Text {
        
        public static let requiredField: String = "*"
        public static let attributedText: [NSAttributedString.Key: Any] = [.foregroundColor: Constants.Color.textLightColor,
                                                                           .font: Constants.Font.fontTiny]
        public static let attributedTextLink: [NSAttributedString.Key: Any] = [.foregroundColor: Constants.Color.appColor,
                                                                               .font: Constants.Font.fontExtraTiny,
                                                                               .underlineColor: Constants.Color.appColor,
                                                                               .underlineStyle: NSUnderlineStyle.single.rawValue]
    }

}
