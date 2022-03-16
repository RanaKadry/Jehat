//
//  StringExtensions.swift
//  Driver
//
//  Created by Peter Bassem on 26/12/2020.
//  Copyright © 2020 Eslam Maged. All rights reserved.
//

import UIKit

// MARK: - Localization
extension String {
    
    func localized() -> String {
        let path = Bundle.main.path(forResource: LocalizationHelper.getCurrentLanguage(), ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

// MARK: - Validations
extension String {
    
    var isAllDigits: Bool {
        let charcterSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let inputString = components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return self == filtered
    }
    
    var isPhoneNumber: Bool {
        if isAllDigits == true {
            let phoneRegex = "([0-9]{9})" // "^(05)([0-9]{8})"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return predicate.evaluate(with: self)
        } else {
            return false
        }
    }
    
    var hasSpecialCharacter: Bool {
        let validString = CharacterSet(charactersIn: "!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢0123456789")
        if rangeOfCharacter(from: validString) != nil {
            return true
        } else {
            return false
        }
    }
    
    func isAllSpaces() -> Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count == 0
    }
    
    func isValidName() -> Bool {
        if hasSpecialCharacter || count > 60 || isEmpty || isAllSpaces() {
            return false
        }
        return true
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidUrl: Bool {
        guard !contains("..") else { return false }
        let head     = "((http|https)://)?([(w|W)]{3}+\\.)?"
        let tail     = "\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
        let urlRegEx = head+"+(.)+"+tail
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: trimmingCharacters(in: .whitespaces))
    }
    
    func removeFirstZero() -> String {
        var newStr = self
        if newStr.count > 0, newStr.prefix(1) == "0" {
            newStr.removeFirst()
        }
        return newStr
    }

    func convertToArray() -> [String] {
        let array = components(separatedBy: ",")
        return array
    }

    init(array: [String], separator: String = ",") {
        self = array.reduce("", { (res, obj) -> String in
            var separator = separator
            if res.isEmpty {
                separator = ""
            }
            return res + separator + obj
        })
    }

    func checkIfContainsUrl() -> Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))
        var url = ""
        for match in matches {
            guard let range = Range(match.range, in: self) else { continue }
            url = String(self[range])
            print(url)
        }
        return !url.isEmpty
    }

    init(array: [Int]) {
        self = array.reduce("", { (res, obj) -> String in
            var separator = ","
            if res.isEmpty {
                separator = ""
            }
            return res + separator + "\(obj)"
        })
    }
    
    func isPasswordContainsWhiteSpaces(password: String) -> Bool {
        return password.trimmingCharacters(in: .whitespaces).isEmpty ? false : true
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func removeUnderscores() -> String {
        return replacingOccurrences(of: "_", with: " ")
    }
    
    func removeWhiteSpaces() -> String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    func removeLeadingAndTrailingSpaces() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getArray(seprationBy separationBy: String = "-") -> [String] {
        return components(separatedBy: separationBy)
    }
    
    init(fromFile fileName: String, withExtension ext: String) {
        let fileUrl = Bundle.main.url(forResource: fileName, withExtension: ext)!
        do {
            self = try String(contentsOf: fileUrl, encoding: .utf8)
        } catch {
            self = ""
        }
    }
    
    var fourDigitNumber: String {
        var result = ""
        repeat {
            // Create a string with a random number 0...9999
            result = String(format: "%04d", arc4random_uniform(10000))
        } while Set<Character>(result).count < 4
        return result
    }
    
    func heightForView(font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height
    }
    
    func widthForView(font: UIFont, height: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.width
    }
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func toURL() -> URL? {
        return URL(string: self)
    }
    
    func toImage() -> UIImage? {
        return UIImage(named: self)
    }
    
    func toColor() -> UIColor? {
        return UIColor(named: self)
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.daySlashMonthSlashShortYear.rawValue
        return dateFormatter.date(from: self)
    }
    
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    func removeSlashes() -> String {
        return self.replace(string: "/", replacement: "")
    }
    
    var arToEnDigits: String {
        let arabicNumbers = ["٠": "0", "١": "1", "٢": "2", "٣": "3", "٤": "4", "٥": "5", "٦": "6", "٧": "7", "٨": "8", "٩": "9"]
        var txt = self
        _ = arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
    
    var enToArDigits: String {
        let englishNumbers = ["0": "٠", "1": "١", "2": "٢", "3": "٣", "4": "٤", "5": "٥", "6": "٦", "7": "٧", "8": "٨", "9": "٩"]
        var txt = self
        _ = englishNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
}

extension String {

    // MARK: - String to [URLQueryItem]

    func toURLQueryItems() -> [URLQueryItem]? {
        guard let urlString = self.removingPercentEncoding, let url = URL(string: urlString) else { return nil }
        if let querItems = url.toQueryItems() { return querItems }
        var urlComponents = URLComponents()
        urlComponents.query = urlString
        return urlComponents.queryItems
    }

    // MARK: - attempt to cast string to correct type (int, bool...)

    func toCorrectType() -> Any {
        let types: [LosslessStringConvertible.Type] = [Bool.self, Int.self, Double.self]
        func cast<T>(to: T) -> Any? { return (to.self as? LosslessStringConvertible.Type)?.init(self) }
        for type in types { if let value = cast(to: type) { return value } }
        return self
    }
}
