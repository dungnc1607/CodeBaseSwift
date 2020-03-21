//
//  BaseFieldContainerView.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

class BaseFieldContainerView: BaseStackView, BindableType {
    // MARK: - Properties
    
    var viewModel: BaseViewModel!
    
    let contentView: UIView
    let titleKey: String?
    let shouldShowTitle: Bool
    let shouldAllowEdit: Bool
    let isRequired: Bool
    
    fileprivate lazy var titleContainerView: UIView = { [unowned self] in
        let titleContainerView = UIView.init()
        titleContainerView.backgroundColor = UIColor.clear
        titleContainerView.addSubview(self.titleLabel)
        titleContainerView.addSubview(self.buttonEdit)
        titleContainerView.isHidden = self.titleLabel.isHidden
        return titleContainerView
        }()
    
    lazy var titleLabel: UILabel = { [unowned self] in
        let titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = Constants.Color.textLightColor
        titleLabel.font = Constants.Font.fontTiny
        titleLabel.textAlignment = .left
        titleLabel.isHidden = !(self.shouldShowTitle && self.titleKey != nil )
        return titleLabel
        }()
    
    lazy var buttonEdit: UIButton = { [unowned self] in
        let buttonEdit = UIButton.init(type: .system)
        buttonEdit.backgroundColor = UIColor.clear
        buttonEdit.setTitleColor(Constants.Color.appColor, for: .normal)
        buttonEdit.titleLabel?.font = Constants.Font.fontTiny
        buttonEdit.isHidden = !self.shouldAllowEdit
        return buttonEdit
        }()
    
    lazy var detailLabel: UILabel = { [unowned self] in
        let detailLabel = UILabel.init()
        detailLabel.backgroundColor = UIColor.clear
        detailLabel.textColor = Constants.Color.textLightColor
        detailLabel.font = Constants.Font.fontTiny
        detailLabel.numberOfLines = 2
        detailLabel.textAlignment = .center
        detailLabel.isHidden = true
        return detailLabel
        }()
    
    lazy var errorLabel: UILabel = {
        let errorLabel = UILabel.init()
        errorLabel.backgroundColor = UIColor.clear
        errorLabel.textColor = Constants.Color.textLightColor
        errorLabel.font = Constants.Font.fontTiny
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .left
        errorLabel.isHidden = true
        return errorLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView.init()
        lineView.backgroundColor = Constants.Color.lineColor
        lineView.isHidden = true
        return lineView
    }()
    
    // MARK: - Dealloc
    
    deinit {
        //        print("deinit " + String(describing: self))
    }
    
    // MARK: - Initialization
    
    init(with contentView: UIView,
         titleKey: String? = nil,
         shouldShowTitle: Bool = true,
         shouldAllowEdit: Bool = false,
         isRequired: Bool = true) {
        
        self.contentView = contentView
        self.titleKey = titleKey
        self.shouldShowTitle = shouldShowTitle
        self.shouldAllowEdit = shouldAllowEdit
        self.isRequired = isRequired
        super.init(frame: .zero)
    }
    
    required init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Override Methods
    
    override func setupUI() {
        super.setupUI()
        
        spacing = Constants.UI.paddingThin / 2
        
        addArrangedSubview(titleContainerView)
        addArrangedSubview(detailLabel)
        addArrangedSubview(contentView)
        addArrangedSubview(errorLabel)
        addArrangedSubview(lineView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        titleContainerView.snp.makeConstraints { (make) in
            make.height.equalTo(20.0 * Constants.UI.displayScale)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.greaterThanOrEqualTo(buttonEdit.snp.leading).offset(-Constants.UI.padding)
            make.centerY.equalToSuperview()
        }
        
        buttonEdit.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(titleLabel)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(Constants.UI.lineHeight)
        }
    }
    
    override func setupCornerRadius() {
        super.setupCornerRadius()
        
    }
    
    override func setupGestures() {
        super.setupGestures()
        
    }
    
    override func driveUI() {
        super.driveUI()
        
        if shouldShowTitle, let titleKey = titleKey {
            LocalizableService.shared.localizedText(with: titleKey)
                .drive(onNext: { [unowned self] title in
                    if !self.isRequired {
                        self.titleLabel.text = title
                    } else {
                        let attributedText = NSMutableAttributedString.init(string: title + Constants.Text.requiredField,
                                                                            attributes: [.foregroundColor: self.titleLabel.textColor!, .font: self.titleLabel.font!])
                        attributedText.addAttributes([.foregroundColor: Constants.Color.errorColor, .font: self.titleLabel.font!],
                                                     range: attributedText.mutableString.range(of: Constants.Text.requiredField))
                        self.titleLabel.attributedText = attributedText
                    }
                })
                .disposed(by: rx.disposeBag)
        }
        
        if shouldAllowEdit {
            LocalizableService.shared.localizedText(with: "Edit")
                .drive(buttonEdit.rx.title(for: .normal))
                .disposed(by: rx.disposeBag)
        }
    }
    
    override func configureStream() {
        super.configureStream()
        
        detailLabel.rx.observe(String.self, "text")
            .map { return $0 == nil }
            .bind(to: detailLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        errorLabel.rx.observe(String.self, "text")
            .map { return $0 == nil }
            .bind(to: errorLabel.rx.isHidden)
            .disposed(by: rx.disposeBag)
    }
    
    override func handleCleanUp() {
        super.handleCleanUp()
        
    }
    
    // MARK: - BindableType
    
    func bindViewModel() {
        
    }
    
    func executeViewModelAction() {
        
    }
}

