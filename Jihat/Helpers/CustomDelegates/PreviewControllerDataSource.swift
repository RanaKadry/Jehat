//
//  PreviewControllerDataSource.swift
//  Jihat
//
//  Created by Peter Bassem on 06/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation
import QuickLook

class PreviewControllerDataSource: QLPreviewControllerDataSource {
    
    private let previewItem: URL
    
    init(previewItem: URL) {
        self.previewItem = previewItem
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
       return self.previewItem as QLPreviewItem
    }
}
