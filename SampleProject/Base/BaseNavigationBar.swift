//
//  BaseNavigationBar.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

class BaseNavigationBar: UINavigationBar {
    // MARK: - Properties
    
    public static let customNavigationBarHeight: CGFloat = 80.0
    public static let customNavigationBarOffset: CGFloat = Constants.UI.getSafeAreaTopPadding() == 0 ?
                                                            BaseNavigationBar.customNavigationBarHeight - 64.0 : 0
    
    // MARK: - Override Methods
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: BaseNavigationBar.customNavigationBarHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frame = CGRect(x: frame.origin.x, y: 0, width: frame.size.width, height: BaseNavigationBar.customNavigationBarHeight)
        
        if let barBackground = subviews.first(where: { NSStringFromClass($0.classForCoder).contains("BarBackground") }) {
            barBackground.frame = CGRect(x: 0, y: 0, width: frame.width, height: BaseNavigationBar.customNavigationBarHeight)
        }
        
        if let barContent = subviews.first(where: { NSStringFromClass($0.classForCoder).contains("BarContent") }) {
            let statusBarHeight: CGFloat = 30.0
            barContent.frame = CGRect(x: barContent.frame.origin.x, y: statusBarHeight, width: barContent.frame.width, height: BaseNavigationBar.customNavigationBarHeight - statusBarHeight)
        }
    }
}
