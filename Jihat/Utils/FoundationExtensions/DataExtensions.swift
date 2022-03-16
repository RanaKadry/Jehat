//
//  DataExtensions.swift
//  Jihat
//
//  Created by Peter Bassem on 11/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    
    var toImage: UIImage? {
        return UIImage(data: self)
    }
}
