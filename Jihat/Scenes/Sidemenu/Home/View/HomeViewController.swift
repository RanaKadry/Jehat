//
//  HomeViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 21/09/2021.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar! {
        didSet { appNavigationBar.itemsCount = presenter.itemsCount }
    }
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet { setupSearchBar() }
    }
    @IBOutlet private weak var searchFilterActionButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var newActionButton: TitleWithImageButton!
    
    // MARK: - Variables
    var presenter: HomePresenterProtocol!
    var collectionViewDataSetup: CollectionView<AppNavigationItemWithImageCollectionViewCell>!
    var userSelectionType: UserHomeActions = .orders
    
    private lazy var blurView: BlurView = {
       let blurView = BlurView()
        return blurView
    }()
    var _blurView: BlurView {
        return blurView
    }
    var _appNavigationBar: AppNavigationBar {
        return appNavigationBar
    }
    var _searchFilterActionButton: UIButton {
        return searchFilterActionButton
    }
    private var searchBarDelegate: SearchBarDelegate!
    var _collectionView: UICollectionView {
        return collectionView
    }
    var _newActionButton: TitleWithImageButton {
        return newActionButton
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupAppNavigationBar()
        updateViewConstraints()
        setupBlurView()
        setupCollectionView()
        SideMenuNavigationViewController.addOpenSideMenuGesture(toView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SideMenuNavigationViewController.removeLeftMenuNavigationController()
        SideMenuNavigationViewController.removeRightMenuNavigationController()
    }
}

// MARK: - Helpers
extension HomeViewController {
    
    private func setupAppNavigationBar() {
        
        appNavigationBar.sidemenuButtonPressed = { [weak self] in
            self?.presenter.performOpenSidemenu()
        }
        
        appNavigationBar.contactUsPressed = { [weak self] in
            self?.presenter.performContactUs()
        }
    }
    
    func setupAppNavigationBarCollectionView() {
        presenter.didSelectNavigationBarCellItem(atIndex: 0)
        collectionViewDataSetup = CollectionView(itemsCount: presenter.itemsCount, itemConfigurator: { [weak self] cell, index in
            self?.presenter.configureNavigationBarCellItem(cell, atIndex: index)
        }, itemSelector: { [weak self] index in
            self?.presenter.didSelectNavigationBarCellItem(atIndex: index)
        }, itemSize: .init(width: UIScreen.main.bounds.width / CGFloat(presenter.itemsCount), height: appNavigationBar._collectionView.frame.size.height), itemSpacing: 0)
        appNavigationBar._collectionView.dataSource = collectionViewDataSetup
        appNavigationBar._collectionView.delegate = collectionViewDataSetup
        appNavigationBar._collectionView.registerCell(cell: AppNavigationItemWithImageCollectionViewCell.self)
        appNavigationBar._collectionView.showsHorizontalScrollIndicator = false
        appNavigationBar._collectionView.showsVerticalScrollIndicator = false
        if let layout = appNavigationBar._collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    private func setupBlurView() {
        view.addSubview(blurView)
        blurView.fillSuperview()
        blurView.alpha = 0
    }
    
    private func setupSearchBar() {
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = true
        searchBar.placeholder = "search".localized()
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.backgroundColor = DesignSystem.Colors.background3Color.color
        textFieldInsideUISearchBar?.cornerRadius = 4
        textFieldInsideUISearchBar?.borderWidth = 0.5
        textFieldInsideUISearchBar?.borderColor = DesignSystem.Colors.text4Color.color
        textFieldInsideUISearchBar?.font = DesignSystem.Typography.paragraphSmall.font
        textFieldInsideUISearchBar?.textColor = DesignSystem.Colors.text3Color.color
        textFieldInsideUISearchBar?.clearButtonMode = .whileEditing
        let searchIconImageView = textFieldInsideUISearchBar?.leftView as? UIImageView
        searchIconImageView?.image = searchIconImageView?.image?.withRenderingMode(.alwaysTemplate)
        searchIconImageView?.tintColor = DesignSystem.Colors.text3Color.color
        searchBarDelegate = SearchBarDelegate(isSearching: { [weak self] searching in
            self?.presenter.updateIsSearching(searching)
        }, searchText: { [weak self] searchText in
            self?.presenter.searchItems(withSearchText: searchText)
        })
        searchBar.delegate = searchBarDelegate
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.registerCell(cell: MyOrderItemCollectionViewCell.self)
        collectionView.registerCell(cell: MyMeetingItemCollectionViewCell.self)
        collectionView.registerCell(cell: MyCalendarItemCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
    }
    
    func updateCollectionViewHeight() {
        collectionView.reloadData()
        collectionView.backgroundView = nil
    }
}

// MARK: - Selectors
extension HomeViewController {
    
    @IBAction
    private func searchFilterActionButtonDidPressed(_ sender: UIButton) {
        presenter.performSearchFilterActionButton()
    }
    
    @IBAction
    private func newActionButtonDidPressed(_ sender: TitleWithImageButton) {
        presenter.performNewActionButton()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.userItemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch userSelectionType {
        case .orders:
            let cell = collectionView.dequeueCell(at: indexPath) as MyOrderItemCollectionViewCell
            cell.index = indexPath.item
            cell.delegate = self
            presenter.configureMyOrderItemCell(cell, atIndex: indexPath.item)
            return cell
        case .meetings:
            let cell = collectionView.dequeueCell(at: indexPath) as MyMeetingItemCollectionViewCell
            cell.index = indexPath.item
            cell.delegate = self
            presenter.configureMyMeetingItemCell(cell, atIndex: indexPath.item)
            return cell
        case .calendars:
            let cell = collectionView.dequeueCell(at: indexPath) as MyCalendarItemCollectionViewCell
            cell.index = indexPath.item
            cell.delegate = self
            presenter.configureMyCalendarItemCell(cell, atIndex: indexPath.item)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(atIndex: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch userSelectionType {
        case .orders:
            return .init(width: collectionView.frame.size.width - 20, height: 133)
        case .meetings:
            return .init(width: collectionView.frame.size.width, height: 172)
        case .calendars:
            return .init(width: collectionView.frame.size.width, height: 172)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch userSelectionType {
        case .orders:
            return 22
        case .meetings, .calendars:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch userSelectionType {
        case .orders:
            return 22
        case .meetings, .calendars:
            return 0
        }
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension HomeViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        presenter.performPrefetchItems(atIndexPaths: indexPaths)
    }
    
    func collectionViewcollectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) { }
}

// MARK: - MyOrderItemCollectionViewCellDelegate && MyCalendarItemCollectionViewCellDelegate
extension HomeViewController: MyOrderItemCollectionViewCellDelegate, MyCalendarItemCollectionViewCellDelegate, MyMeetingItemCollectionViewCellDelegate {
    
    func showDetailsButtonPressed(atIndex index: Int) {
        presenter.didSelectItem(atIndex: index)
    }
}
