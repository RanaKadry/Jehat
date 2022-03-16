//
//  NetworkConstants.swift
//  Attendance
//
//  Created by Peter Bassem on 12/16/19.
//  Copyright © 2019 iMac. All rights reserved.
//
import Foundation

struct KNetworkConstants {
    struct ProductionServer {
        static let baseURL = "https://gtmapi.gtm.easygo.systems/api/"
    }
    
    enum APIQueryKey: String {
        case card, password, country, gender
        case arabicName = "Name_ar"
        case englishName = "Name_en"
        case phone = "Mobile"
        case email = "Mail"
        case id = "Card"
        case registerPassword = "Pass"
        
    }
    
    enum APIParameterKey: String {
        case userProfileImage = "image"
        case nationalIdFront = "national_id_front"
        case nationalIdBack = "national_id_back"
        case driverIdFront = "driving_license_front"
        case driverIdBack = "driving_license_back"
        case vehicleIdFront = "vehicle_license_front"
        case vehicleIdBack = "vehicle_license_back"
        case companyCommercialImage = "commercial_registration_image"
        case companyTaxId = "tax_id_front"
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case acceptLanguage = "Accept-Language"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formData = "form-data"
        case multipart = "multipart/form-data"
        case bearer = "Bearer"
    }
    
    enum EndPoint: String {
        case addOrder = "TicketsController/AddTransaction"
        case addORderAttachments = "TicketsController/AddTransactionAttahments"
        case voteMeetingTerm = "MeetingsController/VoteOnTerms"
        case editVoteMeetingTerm = "MeetingsController/EditVoteOnTerms"
        case voteCandidateTypeOne = "MeetingsController/VoteOnCandidateTypeOne"
        case voteCandidateTypeTwo = "MeetingsController/VoteOnCandidateTypeTwo"
        case voteCandidateTypeThree = "MeetingsController/VoteOnCandidateTypeThree"
        case addAppointment = "AppointmentController/AddAppointment"
        case addDocument = "DocumentsController/AddDocument"
        case editDocument = "DocumentsController/EditDocument"
        case orderAddComment = "TicketsController/EnterComment"
    }
}
