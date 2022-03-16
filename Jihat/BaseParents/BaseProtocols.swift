//
//  BaseProtocols.swift
//  Aman Elshark
//
//  Created by Peter Bassem on 1/12/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showErrorAlert(error: String)
    func showErrorMessage(message: String)
    func showBottomMessage(_ message: String)
}

protocol BasePresenterProtocol: AnyObject {
    func showErrorAlert(error: String)
}

protocol BaseRouterProtocol {
    func showCountriesList()
    func popupViewController()
    func dismissViewController()
    func presentImagePickerViewController(completion: @escaping (UIImage) -> Void)
    func presentImagePickerMultiSelectViewController(imagesLimit: Int, completion: @escaping (_ images: [UIImage], _ urls: [URL?]) -> Void)
    func presentDocumentsPickerMultiScreenViewController(completion: @escaping ([URL]) -> Void)
    func openBrowser(fromUrl url: String)
    func presentDocumentPreveiwViewController(fileurl: URL)
    func showSettingsAlert()
    func presentActionControl(title: String?, message: String?, firstActionTitle: String?, firstAction: (() -> Void)?, secondActionTitle: String?, secondAction: (() -> Void)?)
    func presentActionControl(title: String?, message: String?, actionTitle: String?, action: (() -> Void)?)
    func presentAlertControl(title: String?, message: String?, actionTitle: String?, action: (() -> Void)?)
    func dismissActionControl()
}

protocol BaseInteractorInputProtocol: AnyObject {
    
}

protocol BaseInteractorOutputProtocol: AnyObject {
    
}
