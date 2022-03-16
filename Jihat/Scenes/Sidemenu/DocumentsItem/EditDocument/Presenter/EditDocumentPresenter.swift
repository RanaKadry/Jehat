//
//  EditDocumentPresenter.swift
//  Jihat
//
//  Created Ahmed Barghash on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: EditDocument Presenter -
typealias UpdateDocumentCompletion = (_ updatedDocument: DocumentsResponse, _ index: Int) -> Void

class EditDocumentPresenter: BasePresenter {
    

    weak var view: EditDocumentViewProtocol?
    private let interactor: EditDocumentInteractorInputProtocol
    private let router: EditDocumentRouterProtocol
    private let documentId: String
    private let index: Int
    private let updateDocumentCompletion: UpdateDocumentCompletion
    
    private var documentArabicName: String?
    private var documentEnglishName: String?
    private var documentNumber: String?
    private var documentEndDate: String?
    
    private var attachments: [DocumentsResponseAttachments] = []
    private var modifiedAttachments: [DocumentsResponseAttachments] = []
    
    private var attachmentsData: [String: [Data]] = [:]
    private var imagesData: [Data] = []
    
    init(view: EditDocumentViewProtocol, interactor: EditDocumentInteractorInputProtocol, router: EditDocumentRouterProtocol, documentId: String, index: Int, updateDocumentCompletion: @escaping UpdateDocumentCompletion) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.documentId = documentId
        self.index = index
        self.updateDocumentCompletion = updateDocumentCompletion
    }
}

// MARK: - EditDocumentPresenter
extension EditDocumentPresenter: EditDocumentPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading()
        interactor.getDocumentDetails(documentDetailsRequest: DocumentDetailsRequest(userToken: interactor.userToken, id: documentId))
    }
    
    func validateInputs(arabicName: String?, englishName: String?, documentNumber: String?, endDate: String?) {
        var observeInputs: Bool
        if arabicName?.isEmpty == false && englishName?.isEmpty == false && documentNumber?.isEmpty == false && endDate?.isEmpty == false && !modifiedAttachments.isEmpty {
            observeInputs = (arabicName?.isEmpty == false && self.documentArabicName?.removeLeadingAndTrailingSpaces() != arabicName?.removeLeadingAndTrailingSpaces()) || (englishName?.isEmpty == false && self.documentEnglishName?.removeLeadingAndTrailingSpaces() != englishName?.removeLeadingAndTrailingSpaces()) || (documentNumber?.isEmpty == false && self.documentNumber?.removeLeadingAndTrailingSpaces() != documentNumber?.removeLeadingAndTrailingSpaces()) || (endDate?.isEmpty == false && self.documentEndDate?.removeLeadingAndTrailingSpaces() != endDate?.removeLeadingAndTrailingSpaces()) // || (attachments.count != modifiedAttachments.count && !(attachments.difference(from: modifiedAttachments).isEmpty))
        } else {
            observeInputs = false
        }
        observeInputs ? view?.enableSaveChangesButton() : view?.disableSaveChangesButton()
    }
}

// MARK: - API
extension EditDocumentPresenter: EditDocumentInteractorOutputProtocol {
    
    func fetchingDocumentDetailsWithSuccess(document: DocumentsResponse) {
        view?.hideLoading()
        
        documentArabicName = document.arabicName
        documentEnglishName = document.englishName
        documentNumber = document.documentNumber
        documentEndDate = Date.localizedDate(date: String(document.endDate?.split(separator: "-").last ?? ""))
//        if let userAttachments = document.attachments {
//            userAttachments.forEach {
//                guard let url = URL(string: $0.fileLink ?? "") else { print("unvalid url"); return }
//                do {
//                    if ($0.fileLink ?? "").contains(".jpeg") || ($0.fileLink ?? "").contains(".png") {
//                        let imageData = try Data(contentsOf: url)
//                        imagesData.append(imageData)
//                    } else {
//                        let fileExtension = String(url.lastPathComponent.split(separator: ".").last!)
//                        let urlData = try Data(  contentsOf: url)
//                        if fileExtension.lowercased().contains("pdf") {
//                            if attachmentsData["pdf"] != nil {
//                               attachmentsData["pdf"]?.append(urlData)
//                            } else {
//                                attachmentsData["pdf"] = [urlData]
//                            }
//                        } else if fileExtension.lowercased().contains("txt") {
//                            if attachmentsData["txt"] != nil {
//                                attachmentsData["txt"]?.append(urlData)
//                            } else {
//                                attachmentsData["txt"] = [urlData]
//                            }
//                        } else if fileExtension.lowercased().contains("doc") {
//                            if attachmentsData["doc"] != nil {
//                                attachmentsData["doc"]?.append(urlData)
//                            } else {
//                                attachmentsData["doc"] = [urlData]
//                            }
//                        } else if fileExtension.lowercased().contains("xls") {
//                            if attachmentsData["xls"] != nil {
//                                attachmentsData["xls"]?.append(urlData)
//                            } else {
//                                attachmentsData["xls"] = [urlData]
//                            }
//                        } else if fileExtension.lowercased().contains("ppt") {
//                            if attachmentsData["ppt"] != nil {
//                                attachmentsData["ppt"]?.append(urlData)
//                            } else {
//                                attachmentsData["ppt"] = [urlData]
//                            }
//                        }
//                    }
//                    print("attachment downloaded successfully!")
//                } catch let error {
//                    print("Failed to get attachment data from url \($0.fileLink ?? ""):", error)
//                }
//            }
//        }
        
        view?.set(documentArabicName: document.arabicName ?? "")
        view?.set(documentEnglishName: document.englishName ?? "")
        let docNumber = LocalizationHelper.isArabic() ? document.documentNumber?.enToArDigits : document.documentNumber?.arToEnDigits
        view?.set(documentNumber: docNumber ?? (document.documentNumber ?? ""))
        let endDateString = String(document.endDate?.split(separator: "-").last ?? "")
        view?.setEndDate(endDate: Date.localizedDate(date: endDateString))
        let attachmentsCount = LocalizationHelper.isArabic() ? document.attachments?.count.toString().enToArDigits : document.attachments?.count.toString().arToEnDigits
        view?.set(attachemtsCount: String(format: "%@ %@ %@", "number".localized(), (attachmentsCount ?? ""), "attached_files".localized()))
        self.attachments = document.attachments ?? []
        self.modifiedAttachments = document.attachments ?? []
        view?.refreshCollectionView()
    }
    
    func fetchingDownloadedDocumentWithSuccess(localFileUrl: URL) {
        router.presentDocumentPreveiwViewController(fileurl: localFileUrl)
    }
    
    func fetchingEditDocumentWithSuccess(message: String) {
        view?.stopLoadingOnSaveButton()
        view?.showBottomMessage(message)
        let updatedDocumet = DocumentsResponse(id: documentId, arabicName: documentArabicName, englishName: documentEnglishName, documentNumber: documentNumber, endDate: documentEndDate, attachments: nil)
        updateDocumentCompletion(updatedDocumet, index)
        router.popupViewController()
    }
    
    func fetchingWithError(error: String) {
        view?.hideLoading()
        view?.showBottomMessage(error)
    }
}

// MARK: - Selector
extension EditDocumentPresenter {
    
    func performEditDocumentArabicName() {
        view?.enableEditDocumentArabicNameTextField()
    }
    
    func performEditDocumentEnglishName() {
        view?.enableEditDocumentEnglishNameTextField()
    }
    
    func performEditDocumentNumber() {
        view?.enableEditDocumentNumberTextField()
    }
    
    func performEditEndDate() {
        view?.enableEditEndDateTextField()
    }
    
    func performChangeEndtDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormates.daySlashMonthSlashYear.rawValue
        view?.setEndDate(endDate: dateFormatter.string(from: date))
        validateInputs(arabicName: documentArabicName, englishName: documentEnglishName, documentNumber: documentNumber, endDate: dateFormatter.string(from: date))
    }
    
    func performEditAttachments() {
        view?.showAddImagesButton()
        view?.showAttachmentsImagesButton()
        view?.enableAttachmentsCollectionView()
        view?.showBottomMessage("edit_attachments_tip".localized())
    }
    
    func performDeleteAttachment(atIndex index: Int) {
        router.presentActionControl(title: "are_you_sure_delete".localized(), message: nil, firstActionTitle: "delete".localized(), firstAction: { [weak self] in
            guard let self = self else { return }
            self.modifiedAttachments.remove(at: index)
            self.view?.refreshCollectionView()
            let attachmentsCount = LocalizationHelper.isArabic() ? self.modifiedAttachments.count.toString().enToArDigits : self.modifiedAttachments.count.toString().arToEnDigits
            self.view?.set(attachemtsCount: String(format: "%@ %@ %@", "number".localized(), attachmentsCount, "attached_files".localized()))
        }, secondActionTitle: "cancel".localized()) { }
    }
    
    func performAttachImagesButtonPressed() {
        router.presentImagePickerMultiSelectViewController(imagesLimit: 5) { [weak self] images, imageUrls in
            for (index, url) in imageUrls.enumerated() {
                self?.modifiedAttachments.append(DocumentsResponseAttachments(fileId: nil, fileLink: "\(url ?? URL(string: ""))", fileImage: images[index]))
                self?.imagesData.append(images[index].jpegData(compressionQuality: 0.8) ?? Data())
            }
            self?.view?.refreshCollectionView()
            let attachmentsCount = LocalizationHelper.isArabic() ? self?.modifiedAttachments.count.toString().enToArDigits : self?.modifiedAttachments.count.toString().arToEnDigits
            self?.view?.set(attachemtsCount: String(format: "%@ %@ %@", "number".localized(), attachmentsCount ?? "-1", "attached_files".localized()))
        }
    }
    
    func performAttachDocumentsButtonPressed() {
        router.presentDocumentsPickerMultiScreenViewController { [weak self] urls in
            urls.forEach {
                self?.modifiedAttachments.append(DocumentsResponseAttachments(fileId: nil, fileLink: "\($0)"))
                do {
                    let fileExtension = String($0.lastPathComponent.split(separator: ".").last!)
                    let urlData = try Data(  contentsOf: $0)

                    if fileExtension.lowercased().contains("pdf") {
                        if self?.attachmentsData["pdf"] != nil {
                            self?.attachmentsData["pdf"]?.append(urlData)
                        } else {
                            self?.attachmentsData["pdf"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("txt") {
                        if self?.attachmentsData["txt"] != nil {
                            self?.attachmentsData["txt"]?.append(urlData)
                        } else {
                            self?.attachmentsData["txt"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("doc") {
                        if self?.attachmentsData["doc"] != nil {
                            self?.attachmentsData["doc"]?.append(urlData)
                        } else {
                            self?.attachmentsData["doc"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("xls") {
                        if self?.attachmentsData["xls"] != nil {
                            self?.attachmentsData["xls"]?.append(urlData)
                        } else {
                            self?.attachmentsData["xls"] = [urlData]
                        }
                    } else if fileExtension.lowercased().contains("ppt") {
                        if self?.attachmentsData["ppt"] != nil {
                            self?.attachmentsData["ppt"]?.append(urlData)
                        } else {
                            self?.attachmentsData["ppt"] = [urlData]
                        }
                    }
                } catch let error {
                    print("Failed to convert attachment to url:", error)
                }
            }
            self?.view?.refreshCollectionView()
            let attachmentsCount = LocalizationHelper.isArabic() ? self?.modifiedAttachments.count.toString().enToArDigits : self?.modifiedAttachments.count.toString().arToEnDigits
            self?.view?.set(attachemtsCount: String(format: "%@ %@ %@", "number".localized(), attachmentsCount ?? "-1", "attached_files".localized()))
        }
    }
    
    func performSaveChanges(arabicName: String?, englishName: String?, number: String?, endDate: String?) {
//        guard !attachmentsData.isEmpty || !imagesData.isEmpty else { return }
        let editDocumentRequest = EditDocumentRequest(userToken: interactor.userToken, documentId: documentId, arabicName: arabicName, englishName: englishName, number: number, expirationDate: endDate)
        self.documentArabicName = arabicName
        self.documentEnglishName = englishName
        self.documentNumber = number
        self.documentEndDate = endDate
        view?.startLoadingOnSaveButton()
        interactor.editDocument(addDocumentRequest: editDocumentRequest, attachments: [:], images: [])
    }
    
    func performDiscardChanges() {
        router.popupViewController()
    }
}

// MARK: - AttatchmentsCollectionView Setup
extension EditDocumentPresenter {
    
    var attatchmentsCount: Int {
        return modifiedAttachments.count
    }
    
    func configureAttatchemtCell(_ cell: AttatchmentCollectionViewCellProtocol, atIndex index: Int) {
        let attachment = modifiedAttachments[index]
        if (attachment.fileLink ?? "").contains("jpg".uppercased()) {
            cell.setImage(image: attachment.fileImage)
        }
        if (attachment.fileLink ?? "").contains("jpeg") || (attachment.fileLink ?? "").contains("jpg") {
            cell.setImage(attachment.fileLink ?? "")
        } else {
            if (attachment.fileLink ?? "").contains("pdf") {
                cell.setImage(image: DesignSystem.Icon.pdf.image)
            } else if (attachment.fileLink ?? "").contains("doc") {
                cell.setImage(image: DesignSystem.Icon.word.image)
            } else if (attachment.fileLink ?? "").contains("xls") {
                cell.setImage(image: DesignSystem.Icon.excel.image)
            } else if (attachment.fileLink ?? "").contains("ppt") {
                cell.setImage(image: DesignSystem.Icon.powerpoint.image)
            } else if (attachment.fileLink ?? "").contains("txt") {
                cell.setImage(image: DesignSystem.Icon.txt.image)
            } else {
                cell.setImage(image: attachment.fileImage)
            }
        }
    }
    
    func didSelectAttachemt(atIndex index: Int) {
        let attachment = modifiedAttachments[index]
        if attachment.fileImage != nil {
            let attachemtUrlString = attachment.fileLink ?? ""
            let imageNameWithExtension = attachemtUrlString.components(separatedBy: "/").last
            
            if let fileURL = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!).appendingPathComponent(imageNameWithExtension ?? "") {
                interactor.downloadDocument(fileurl: fileURL)
            } else {
                print("IMAGE NOT FOUND!☹️")
            }
        } else {
            guard let url = URL(string: modifiedAttachments[index].fileLink ?? "") else { return }
            interactor.downloadDocument(fileurl: url)
        }
    }
}

