//
//  AppNavigationBar.swift
//  Jihat
//
//  Created by Peter Bassem on 18/09/2021.
//

import UIKit

@IBDesignable
final class AppNavigationBar: BaseView {
    
    // MARK: - Outlets
    @IBOutlet private weak var itemButton: UIButton!
    @IBOutlet private weak var itemTitleLabel: UILabel!
    @IBOutlet private weak var contactUsView: UIView! {
        didSet { contactUsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contactUsViewDidPressed(_:)))) }
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    @IBInspectable
    var prefersLargeTitle: Bool = true {
        didSet { configure() }
    }
    @IBInspectable
    var localizedTitle: String = "" {
        didSet { configureTitle() }
    }
    @IBInspectable
    var backButtonImageName: String = "" {
        didSet { configureButton() }
    }
    @IBInspectable
    var showContactJihat: Bool = false {
        didSet { configureContactJihat() }
    }
    
    var _collectionView: UICollectionView {
        return collectionView
    }
    var itemsCount: Int = 1
    var selectedIndex = 0
    private var indicatorView = UIView()
    private let indicatorHeight: CGFloat = 6
    private var buttonItemType: AppBarButtonType?
    
    // MARK: - Closure Actions
    lazy var itemsCountUpdated: (() -> Void) = { [weak self] in
        self?.setInitialLineView()
    }
    lazy var itemSelected: (() -> Void) = { [weak self] in
        self?.animateIndicator()
    }
    var backButtonPressed: (() -> Void)?
    var sidemenuButtonPressed: (() -> Void)?
    var contactUsPressed: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Private Configuration
    private func configure() {
        xibSetup(contentView: &contentView)
        collectionView.isHidden = !prefersLargeTitle
        heightAnchor.constraint(equalToConstant: prefersLargeTitle ? 140 : 70).isActive = true
    }
    
    private func configureTitle() {
        itemTitleLabel.text = localizedTitle.localized()
    }
    
    private func configureButton() {
        guard !backButtonImageName.isEmpty else { return }
        itemButton.setImage(UIImage(named: backButtonImageName), for: .normal)
        buttonItemType = AppBarButtonType(rawValue: backButtonImageName)
    }
    
    private func configureContactJihat() {
        itemTitleLabel.isHidden = showContactJihat
        contactUsView.isHidden = !showContactJihat
        contactUsView.subviews.forEach { $0.isHidden = !showContactJihat }
    }
}

// MARK: - Helpers
extension AppNavigationBar {
    
    private func setInitialLineView() {
        indicatorView.backgroundColor = .orange
        indicatorView.frame = .init(x: collectionView.bounds.minX, y: collectionView.bounds.maxY - indicatorHeight, width: UIScreen.main.bounds.width / CGFloat(itemsCount), height: indicatorHeight)
        collectionView.addSubview(indicatorView)
    }
    
    func animateIndicator() {
        let desiredX = (collectionView.bounds.width / CGFloat(itemsCount)) * CGFloat(selectedIndex)
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.indicatorView.frame = .init(x: desiredX, y: self.collectionView.bounds.maxY - self.indicatorHeight, width: self.collectionView.bounds.size.width / CGFloat(self.itemsCount), height: self.indicatorHeight)
        }
    }
}

// MARK: - Selectors
extension AppNavigationBar {
    
    @IBAction
    private func buttonItemDidPressed(_ sender: UIButton) {
        guard let buttonItemType = buttonItemType else { return }
        switch buttonItemType {
        case .back:
            backButtonPressed?()
        case .sidemenu:
            sidemenuButtonPressed?()
        }
    }
    
    @objc
    private func contactUsViewDidPressed(_ sender: UIButton) {
        contactUsPressed?()
    }
}
