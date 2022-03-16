//
//  BasePresenter.swift
//  Aman Elshark
//
//  Created by Peter Bassem on 1/12/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import Foundation
import UIKit

class BasePresenter {
    
    func showErrorAlert(error: String) {
        AlertView.AlertViewBuilder().setTitle(with: LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: ""))
            .setMessage(with: error)
            .setAlertType(with: .failure)
            .setButtonTitle(with: LocalizationSystem.sharedInstance.localizedStringForKey(key: "done", comment: ""))
            .build()
    }

    func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func setFont(size fontSize: CGFloat, isBold bold: Bool) -> UIFont {
        if LocalizationSystem.sharedInstance.getLanguage() == "en" {
            return UIFont(name: bold ? "Bariol-Bold" : "Bariol-Regular", size: fontSize)!
        } else {
            return UIFont(name: bold ? "NotoKufiArabic-Bold" : "NotoKufiArabic", size: (fontSize - 2.0))!
        }
    }
    
    func filterDictionary(_ dictionary: inout [String: Any]) -> [String: Any] {
        for (key, value) in dictionary {
            if let valueString = value as? String {
                if valueString == "" {
                    dictionary.removeValue(forKey: key)
                }
            }
        }
        return dictionary
    }
    
    func makeCall(toPhone phone: String) {
        guard let number = URL(string: "tel://" + phone) else { return }
        UIApplication.shared.open(number)
    }
    
    func startWhatpsappChat(withNumber number: String, errorCompletion: ((String) -> Void)?) {
        let urlWhatsapp = "whatsapp://send?phone=+919789384445"
        if let urlString = urlWhatsapp.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    errorCompletion?("whatsapp_not_installed".localized())
                }
            }
        }
    }
}
