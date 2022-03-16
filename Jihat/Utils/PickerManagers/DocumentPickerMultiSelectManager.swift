//
//  DocumentPickerMultiSelectManager.swift
//  Jihat
//
//  Created by Peter Bassem on 05/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class DocumentPickerMultiSelectManager: NSObject {
    
    private static var picker: UIDocumentPickerViewController!
    private static var viewController: UIViewController?
    private static var pickDocumentsCallBack: (([URL]) -> Void)?
    
    private static var pickerDelegate: DocumentPickerMultiSelectManagerDelegate!
    
    override init() {
        super.init()
    }
    
    static func pickDocuments(_ viewController: UIViewController?, _ callback: @escaping (([URL]) -> Void)) {
        pickDocumentsCallBack = callback
        self.viewController = viewController
        
        let documentTypes = [String(kUTTypePDF), String(kUTTypeSpreadsheet), String(kUTTypeCompositeContent), String(kUTTypeText)]
        picker = UIDocumentPickerViewController(documentTypes: documentTypes, in: .import)
        if #available(iOS 11.0, *) {
            picker.allowsMultipleSelection = true
        }
        pickerDelegate = DocumentPickerMultiSelectManagerDelegate(cancelCompletion: {
            picker.dismiss(animated: true, completion: nil)
        }, doneCompletion: { urls in
            callback(urls)
        })
        picker.delegate = pickerDelegate
        picker.modalPresentationStyle = .fullScreen
        viewController?.present(picker, animated: true, completion: nil)
    }
}

class DocumentPickerMultiSelectManagerDelegate: NSObject, UIDocumentPickerDelegate {
    
    private var cancelCompletion: (() -> Void)
    private var doneCompletion: (([URL]) -> Void)
    
    init(cancelCompletion: @escaping (() -> Void), doneCompletion: @escaping (([URL]) -> Void)) {
        self.cancelCompletion = cancelCompletion
        self.doneCompletion = doneCompletion
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        cancelCompletion()
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        doneCompletion(urls)
    }
}
