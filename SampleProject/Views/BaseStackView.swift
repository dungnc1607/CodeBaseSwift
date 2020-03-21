//
//  BaseStackView.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit
import NSObject_Rx

class BaseStackView: UIStackView {

   // MARK: - Dealloc
    
    deinit {
        
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupCornerRadius()
        setupGestures()
        driveUI()
        configureStream()
    }
    
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil {
            handleCleanUp()
        }
    }
    
    // MARK: - Public Methods
    
    func frameNeedUpdate() {
        forceLayout()
        let height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var newFrame = frame
        newFrame.size.height = height
        frame = newFrame
    }
    
    func getHeight() -> CGFloat {
        forceLayout()
        let height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return height
    }
    
    func forceLayout() {
        setNeedsUpdateConstraints()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: - Override Methods
    
    func setupUI() {
        backgroundColor = UIColor.clear
        isOpaque = false
        clipsToBounds = true
        
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 0
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = []
        autoresizesSubviews = false
    }
    
    func setupCornerRadius() {
        
    }
    
    func setupGestures() {
        
    }
    
    func driveUI() {
        
    }
    
    func configureStream() {
        
    }
    
    func handleCleanUp() {
        
    }
}


