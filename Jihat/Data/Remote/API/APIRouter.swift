//
//  APIRouter.swift
//  MandoBee
//
//  Created by Peter Bassem on 18/06/2021.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    
    // Sponsers
    case getSponsers
    
    // User
    case login(loginRequset: LoginRequest)
    case resetPassword(forgetPasswordRequest: ForgetPasswordRequest)
    case registerUser(registerRequest: RegisterRequest)
    case getUserCountries
    case resendVerificationCode(resendVerificationCodeRequest: ResendVerifiyCodeRequest)
    case sendVerificationCode(verificationCodeRequest: VerifyCodeRequest)
    case getUserData(userDataRequest: BaseRequest)
    case updateUserData(updateUserDataRequest: UpdateUserDataRequest)
    case logout(logoutRequest: BaseRequest)
    
    // Tickets (Orders)
    case getOrders(ordersRequest: UserOrdersRequest)
    case orderDepartments
    case orderTransactionTypes(transactionTypesRequest: TransactionTypesRequest)
    case orderTransactionProperties(transactionPropertiesRequest: TransactionPropertiesRequest)
    case orderPriorities
    case addOrder(addOrderRequest: AddOrderRequest, addOrderBodyRequest: [String: [AddOrderBodyRequest]])
    case getOrderDetails(userOrderDetailsRequest: UserOrderDetailsRequest)
    case getOrderCommentsUpdates(userOrderDetailsRequest: UserOrderDetailsRequest)
    case getTicketsFilterItems
    
    // Meetings
    case getMeetings(meetingsRequest: UserMeetingsRequest)
    case getMeetingsFilterItems
    case getMeetingDetails(userMeetingDetailsRequest: UserMeetingDetailsRequest)
    case attendMeeting(attendMeetingRequest: UserMeetingDetailsRequest)
    case getMeetingTerms(userMeetingTermsRequest: UserMeetingDetailsRequest)
    case getMeetingCandidates(userMeetingCandidatesRequest: UserMeetingDetailsRequest)
    
    // Appointments (Calendars)
    case getAppointments(appointmentsRequest: UserAppointmentsRequest)
    case getAppointmentDetails(appointmentDetailsRequest: AppointmentDetailsRequest)
    case getAppointmentTypes
    
    // Commissioners (Delegates)
    case getCommissioners(commissionersRequest: BaseRequest)
    case addCommissioners(addCommissionersRequest: AddDelegateRequest)
    case getSingleCommissioner(singleCommissionerRequest: EditDelegateRequest)
    case updateCommissioner(updateCommissionerRequest: UpdateDelegateRequest)
    case deleteCommissioner(deleteCommissionerRequest: EditDelegateRequest)
    
    // Documents
    case getDocuments(documentsRequest: BaseRequest)
    case deleteDocument(deleteDocumentRequest: DeleteDocumentRequest)
    case getDocumentDetails(documentDetailsRequest: DocumentDetailsRequest)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getSponsers, .login, .resetPassword, .getUserCountries, .getUserData, .logout, .getOrders, .orderDepartments, .orderTransactionTypes, .orderTransactionProperties, .orderPriorities, .getOrderDetails, .getOrderCommentsUpdates, .getTicketsFilterItems, .getMeetings, .getMeetingsFilterItems, .getMeetingDetails, .attendMeeting, .getMeetingTerms, .getMeetingCandidates, .getAppointments, .getAppointmentDetails, .getAppointmentTypes, .getCommissioners, .getSingleCommissioner ,.getDocuments, .getDocumentDetails: return .get
        case .registerUser, .resendVerificationCode, .sendVerificationCode, .updateUserData, .addOrder, .addCommissioners, .updateCommissioner: return .post
        case .deleteCommissioner, .deleteDocument: return .delete
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getSponsers: return "LoginController/Sponsers"
            
        case .login: return "LoginController/Login"
        case .resetPassword: return "LoginController/ForgetPassword"
        case .registerUser: return "RegisterController/AddClient"
        case .getUserCountries: return "RegisterController/Countries"
        case .resendVerificationCode: return "RegisterController/ResendVerifyCode"
        case .sendVerificationCode: return "RegisterController/VerifyClient"
        case .getUserData: return "UserController/UserDate"
        case .updateUserData: return "UserController/UpdateClient"
        case .logout: return "LogoutController/Logout"
            
        case .getOrders: return "TicketsController/UserTickets"
        case .orderDepartments: return "TicketsController/Departments"
        case .orderTransactionTypes: return "TicketsController/TransactionTypes"
        case .orderTransactionProperties: return "TicketsController/Properties"
        case .orderPriorities: return "TicketsController/TickPriority"
        case .addOrder: return "TicketsController/AddTransaction"
        case .getOrderDetails: return "TicketsController/UserTicketData"
        case .getOrderCommentsUpdates: return "TicketsController/TicketComments"
        case .getTicketsFilterItems: return "TicketsController/TicketsFilter"
            
        case .getMeetings: return "MeetingsController/UserMeetings"
        case .getMeetingsFilterItems: return "MeetingsController/MeetingsFilter"
        case .getMeetingDetails: return "MeetingsController/MeetingDetails"
        case .attendMeeting: return "MeetingsController/AttendMeeting"
        case .getMeetingTerms: return "MeetingsController/MeetingTerms"
        case .getMeetingCandidates: return "MeetingsController/MeetingCandidates"
            
        case .getAppointments: return "AppointmentController/UserAppointment"
        case .getAppointmentDetails: return "AppointmentController/AppointmentByID"
        case .getAppointmentTypes: return "AppointmentController/AppointmentType"
            
        case .getCommissioners: return "UserController/UserCommissioners"
        case .addCommissioners: return "UserController/AddCommissioners"
        case .getSingleCommissioner: return "UserController/Commissioner"
        case .updateCommissioner: return "UserController/EditCommissioner"
        case .deleteCommissioner: return "UserController/DeleteCommissioner"
            
        case .getDocuments: return "DocumentsController/UserDocuments"
        case .deleteDocument: return "DocumentsController/DeleteDocument"
        case .getDocumentDetails: return "DocumentsController/SelectUserDocument"
        }
    }
    
    // MARK: - Quary
    var query: [URLQueryItem]? {
        switch self {
        case .getSponsers, .getUserCountries, .orderDepartments, .orderPriorities, .getTicketsFilterItems, .getMeetingsFilterItems, .getAppointmentTypes: return nil
        case .login(let loginRequset):
            return try? loginRequset.asDictionary().toURLQueryItems()
        case .resetPassword(let forgetPasswordRequest):
            return try? forgetPasswordRequest.asDictionary().toURLQueryItems()
        case .registerUser(let registerRequest):
            return try? registerRequest.asDictionary().toURLQueryItems()
        case .getUserData(let userDataRequest):
            return try? userDataRequest.asDictionary().toURLQueryItems()
        case .resendVerificationCode(let resendVerificationCodeRequest):
            return try? resendVerificationCodeRequest.asDictionary().toURLQueryItems()
        case .sendVerificationCode(let verificationCodeRequest):
            return try? verificationCodeRequest.asDictionary().toURLQueryItems()
        case .updateUserData(let updateUserDataRequest):
            return try? updateUserDataRequest.asDictionary().toURLQueryItems()
        case .logout(let logoutRequest):
            return try? logoutRequest.asDictionary().toURLQueryItems()
        case .getOrders(let ordersRequest):
            return try? ordersRequest.asDictionary().toURLQueryItems()
        case .orderTransactionTypes(let transactionTypesRequest):
            return try? transactionTypesRequest.asDictionary().toURLQueryItems()
        case .orderTransactionProperties(let transactionPropertiesRequest):
            return try? transactionPropertiesRequest.asDictionary().toURLQueryItems()
        case .addOrder(let addOrderRequest, _):
            return try? addOrderRequest.asDictionary().toURLQueryItems()
        case .getOrderDetails(let userOrderDetailsRequest), .getOrderCommentsUpdates(let userOrderDetailsRequest):
            return try? userOrderDetailsRequest.asDictionary().toURLQueryItems()
        case .getMeetings(let meetingsRequest):
            return try? meetingsRequest.asDictionary().toURLQueryItems()
        case .getMeetingDetails(let userMeetingDetailsRequest):
            return try? userMeetingDetailsRequest.asDictionary().toURLQueryItems()
        case .attendMeeting(let attendMeetingRequest):
            return try? attendMeetingRequest.asDictionary().toURLQueryItems()
        case .getMeetingTerms(let userMeetingTermsRequest):
            return try? userMeetingTermsRequest.asDictionary().toURLQueryItems()
        case .getMeetingCandidates(let userMeetingCandidatesRequest):
            return try? userMeetingCandidatesRequest.asDictionary().toURLQueryItems()
        case .getAppointments(let appointmentsRequest):
            return try? appointmentsRequest.asDictionary().toURLQueryItems()
        case .getAppointmentDetails(let appointmentDetailsRequest):
            return try? appointmentDetailsRequest.asDictionary().toURLQueryItems()
        case .getCommissioners(let commissionersRequest):
            return try? commissionersRequest.asDictionary().toURLQueryItems()
        case .addCommissioners(let addCommissionersRequest):
            return try? addCommissionersRequest.asDictionary().toURLQueryItems()
        case .getSingleCommissioner(let singleCommissionerRequest):
            return try? singleCommissionerRequest.asDictionary().toURLQueryItems()
        case .updateCommissioner(let updateCommissionerRequest):
            return try? updateCommissionerRequest.asDictionary().toURLQueryItems()
        case .deleteCommissioner(let deleteCommissionerRequest):
            return try? deleteCommissionerRequest.asDictionary().toURLQueryItems()
        case .getDocuments(let documentsRequest):
            return try? documentsRequest.asDictionary().toURLQueryItems()
        case .deleteDocument(let deleteDocumentRequest):
            return try? deleteDocumentRequest.asDictionary().toURLQueryItems()
        case .getDocumentDetails(let documentDetailsRequest):
            return try? documentDetailsRequest.asDictionary().toURLQueryItems()
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getSponsers, .login, .resetPassword, .getUserCountries, .registerUser, .resendVerificationCode, .sendVerificationCode, .getUserData, .updateUserData, .logout, .getOrders, .orderDepartments, .orderTransactionTypes, .orderTransactionProperties, .orderPriorities, .getOrderDetails, .getOrderCommentsUpdates, .getTicketsFilterItems, .getMeetings, .getMeetingsFilterItems, .getMeetingDetails, .attendMeeting, .getMeetingTerms, .getMeetingCandidates, .getAppointments, .getAppointmentDetails, .getAppointmentTypes, .getCommissioners, .addCommissioners, .getSingleCommissioner, .updateCommissioner, .deleteCommissioner, .getDocuments, .deleteDocument, .getDocumentDetails: return nil
        case .addOrder(_, let addOrderBodyRequest):
            do {
                print("properties converted to dicationary sucessfully!")
                return try addOrderBodyRequest.asDictionary()
            } catch {
                print(" error converting properties to dictionary")
                return nil
            }
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var url = try KNetworkConstants.ProductionServer.baseURL.asURL()
        
        if let query = query {
            var urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = query
            url = try (urlComponents?.asURL())!
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        HeaderInterceptor.defaultHeaderInterceptor(fromURLRequest: &urlRequest)
        
        print(urlRequest)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
