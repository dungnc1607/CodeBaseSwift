//
//  BaseViewController.swift
//  SampleProject
//
//  Created by Squall on 2/4/20.
//  Copyright © 2020 Squall. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
        
    public var isFirstLoad: Bool = true
    public var isScrollableViewController: Bool = false
    
    public lazy var buttonBack: UIBarButtonItem = { [unowned self] in
        let image = UIImage.init(named: Constants.ImageName.iconBack)
        let buttonBack = UIBarButtonItem.init(image: image, style: .plain, target: self, action: nil)
        return buttonBack
        }()
    
    public lazy var buttonClose: UIBarButtonItem = { [unowned self] in
        let image = UIImage.init(named: Constants.ImageName.iconClose)
        let buttonClose = UIBarButtonItem.init(image: image, style: .plain, target: self, action: nil)
        return buttonClose
        }()
    
    public lazy var titleLabel: UIBarButtonItem = {
        let titleLabel = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        titleLabel.isEnabled = false
        return titleLabel
    }()
    
    public lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView.init()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.addSubview(self.contentView)
        return scrollView
        }()
    
    public lazy var formBackgroundView: UIView = {
        let formBackgroundView = UIView.init()
        formBackgroundView.backgroundColor = UIColor.white
        formBackgroundView.layer.cornerRadius = Constants.UI.cornerRadius
        formBackgroundView.layer.masksToBounds = true
        formBackgroundView.isUserInteractionEnabled = false
        return formBackgroundView
    }()
    
    public lazy var overlayBackgroundView: UIView = {
        let overlayBackgroundView = UIView.init()
        overlayBackgroundView.backgroundColor = Constants.Color.overlayColor
        overlayBackgroundView.isUserInteractionEnabled = false
        return overlayBackgroundView
    }()
    
    public lazy var contentView: UIView = {
        let contentView = UIView.init()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    public var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }
    
    // MARK: - Dealloc
    
    deinit {
        print("deinit " + String(describing: self))
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupConstraints()
        setupCornerRadius()
        driveUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isScrollableViewController {
            // Warning user that screen is scrollable
            scrollView.flashScrollIndicators()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isFirstLoad {
            isFirstLoad = false
        }
        
        endEditing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        frameNeedUpdate()
    }
    
    // MARK: - Public Methods
    
    public func endEditing() {
        view.endEditing(true)
    }
    
    public func configureScrollableViewController() {
        isScrollableViewController = true
        
        formBackgroundView.removeFromSuperview()
        contentView.addSubview(formBackgroundView)
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            //            make.edges.equalToSuperview()
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(view)
        }
    }
    
    public func configureOverlayBackgroundView(isHidden: Bool) {
        guard !isHidden else {
            overlayBackgroundView.removeFromSuperview()
            return
        }
        navigationController?.view.addSubview(overlayBackgroundView)
        navigationController?.view.bringSubviewToFront(overlayBackgroundView)
        overlayBackgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Override Methods
    
    func setupUI() {
        view.backgroundColor = Constants.Color.backgroundColor
        view.isOpaque = false
        
        view.addSubview(formBackgroundView)
    }
    
    func setupConstraints() {
        view.autoresizingMask = []
        view.autoresizesSubviews = false
    }
    
    func setupCornerRadius() {
        
    }
    
    func driveUI() {
        
    }
    
    func setupNavigationBar() {
        if let navigationController = navigationController as? BaseNavigationController {
            navigationController.configureNavigationBar(with: .colored)
            titleLabel.setTitleTextAttributes(navigationController.getTitleTextAttributes(), for: .normal)
            titleLabel.setTitleTextAttributes(navigationController.getTitleTextAttributes(), for: .disabled)
        }
    }
    
    func frameNeedUpdate() {
        
    }
}
