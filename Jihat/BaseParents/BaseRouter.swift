//
//  BaseRouter.swift
//  MandoBee
//
//  Created by Peter Bassem on 06/07/2021.
//

import Foundation
import UIKit
import SafariServices
import QuickLook

class BaseRouter: BaseRouterProtocol {
    
    weak var viewController: UIViewController?
    private var listCountriesViewController: UIViewController!
    private var actionController: UIAlertController!
    private var previewControllerDataSource: PreviewControllerDataSource!
    
    func showCountriesList() {
        let listNavigationController = PhoneNumberTextField.createListCountriesNavigationController()
        if let listViewController = listNavigationController.viewControllers.first {
            self.listCountriesViewController = listViewController
            listViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries(_:)))
        }
        viewController?.present(listNavigationController, animated: true, completion: nil)
    }
    
    @objc
    private func dismissCountries(_ sender: UIBarButtonItem) {
        listCountriesViewController.dismiss(animated: true, completion: nil)
    }
    
    func popupViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func dismissViewController() {
        viewController?.dismiss(animated: true)
    }
    
    func presentImagePickerViewController(completion: @escaping (UIImage) -> Void) {
        guard let viewController = viewController else { return }
        ImagePickerManager().pickImage(viewController) { image, _ in
            completion(image)
        }
    }
    
    func presentImagePickerMultiSelectViewController(imagesLimit: Int, completion: @escaping (_ images: [UIImage], _ urls: [URL?]) -> Void) {
        guard let viewController = viewController else { return }
        ImagePickerMultiSelectManager.pickImages(viewController, imagesLimit: imagesLimit, completion)
    }
    
    func presentDocumentsPickerMultiScreenViewController(completion: @escaping ([URL]) -> Void) {
        guard let viewController = viewController else { return }
        DocumentPickerMultiSelectManager.pickDocuments(viewController, completion)
    }
    
    func openBrowser(fromUrl url: String) {
        guard let url = URL(string: url) else { return }
        let safariViewController = SFSafariViewController(url: url)
        viewController?.present(safariViewController, animated: true)
    }
    
    func presentDocumentPreveiwViewController(fileurl: URL) {
        let previewController = QLPreviewController()
        previewControllerDataSource = PreviewControllerDataSource(previewItem: fileurl)
        previewController.dataSource = previewControllerDataSource
        viewController?.present(previewController, animated: true, completion: nil)
    }
    
    func showSettingsAlert() {
        viewController?.goToSettings(completion: nil)
    }
    
    func presentActionControl(title: String?, message: String?, firstActionTitle: String?, firstAction: (() -> Void)?, secondActionTitle: String?, secondAction: (() -> Void)?) {
        actionController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let firstAction = UIAlertAction(title: firstActionTitle, style: .default) { _ in
            firstAction?()
        }
        let secondAction = UIAlertAction(title: secondActionTitle, style: .default) { _ in
            secondAction?()
        }
        actionController.addAction(firstAction)
        actionController.addAction(secondAction)
        viewController?.present(actionController, animated: true)
    }
    
    func presentActionControl(title: String?, message: String?, actionTitle: String?, action: (() -> Void)?) {
        actionController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: actionTitle, style: .destructive) { _ in
            action?()
        }
        actionController.addAction(action)
        viewController?.present(actionController, animated: true)
    }
    
    func presentAlertControl(title: String?, message: String?, actionTitle: String?, action: (() -> Void)?) {
        actionController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            action?()
        }
        actionController.addAction(action)
        viewController?.present(actionController, animated: true)
    }
    
    func dismissActionControl() {
        actionController.dismiss(animated: true)
    }
}
