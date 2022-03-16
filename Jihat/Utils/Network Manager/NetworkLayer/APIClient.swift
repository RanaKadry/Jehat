//
//  APIClient.swift
//  Attendance
//
//  Created by Peter Bassem on 12/16/19.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import Alamofire
import PromisedFuture

enum NetworkErrorType: String, Error {
    case noInternet = "error.no_internet"
    case serverError = "error.error_in_server"
    case couldNotParseJson = "error.decoding_error"
    case empty = "error.empty"
    case authenicationRequired = "error.authentication_required"
    case catchError
}

class APIClient {
    
    // MARK: - peroformRequest without Completion Handler
    //        @discardableResult
    //    static func performRequest<T:Decodable>(route:APIConfiguration, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, Error>)->Void) -> DataRequest {
    //        AF.request(route)
    //            .validate(statusCode: 200...3000)
    //            .responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
    //                switch response.result {
    //                case .success(let value):
    //                    completion(.success(value))
    //                case .failure(let error):
    //                    if let data = response.data {
    //                        do {
    //                            let value = try JSONDecoder().decode(T.self, from: data)
    //                            completion(.success(value))
    //                        } catch let error {
    //                            completion(.failure(error))
    //                        }
    //                    } else {
    //                        completion(.failure(error))
    //                    }
    //                }
    //            }
    //    }
    
    // MARK: - peroformRequest with Future
    @discardableResult
    class func performRequest<T: Decodable>(route: APIConfiguration, decoder: JSONDecoder = JSONDecoder()) -> Future<T, NetworkErrorType> {
        guard NetworkManager.isConnectedToInternet else {
            let future = Future<T, NetworkErrorType> { completion in
                completion(.failure(NetworkErrorType.noInternet))
            }
            return future
        }
        return Future(operation: { (completion) in
            AF.request(route)
                .validate(statusCode: 200...300)
                .responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
//                    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
//                    print(response.response?.statusCode ?? -1)
//                    print(response.result)
//                    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(_):
                        if let data = response.data {
                            do {
                                let value = try JSONDecoder().decode(T.self, from: data)
                                completion(.success(value))
                            } catch {
                                completion(.failure(NetworkErrorType.couldNotParseJson))
                            }
                            
                        } else {
                            completion(.failure(NetworkErrorType.serverError))
                        }
                    }
                })
        })
    }
    
    class func uploadImage<T: Codable>(endUrl endPoint: String, token: String, imageData: Data?, imageFileName: String?, parameters: [String: Any], type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = String(format: "%@%@", KNetworkConstants.ProductionServer.baseURL, endPoint)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            if let data = imageData, let name = imageFileName {
                multipartFormData.append(data, withName: "\(name)", fileName: "\(name).jpeg", mimeType: "image/jpg")
            }
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: HeaderInterceptor.multipartHeaderInterceptor()).uploadProgress(queue: .main) { (_) in
            
        }.responseJSON(queue: .main) { (response) in
            print("upload image \(imageFileName ?? "") finished:", response)
        }.responseDecodable { (response: DataResponse<T, AFError>) in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            guard let value = response.value else { return }
            completion(.success(value))
        }
    }
    
    class func uploadImage<T: Codable>(endUrl endPoint: String, token: String? = nil, parameters: [String: Any], images: [String: Data]?, type: T.Type, completion: @escaping (Result<T, NetworkErrorType>) -> Void) {
        
        guard NetworkManager.isConnectedToInternet else {
            completion(.failure(NetworkErrorType.noInternet))
            return
        }
        
        let url = String(format: "%@%@", KNetworkConstants.ProductionServer.baseURL, endPoint)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            if let images = images {
                for (key, value) in images {
                    multipartFormData.append(value, withName: "\(key)", fileName: "\(key).jpeg", mimeType: "image/jpg")
                }
            }
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: HeaderInterceptor.multipartHeaderInterceptor()).uploadProgress(queue: .main) { (progress) in
            print(progress)
        }.responseJSON(queue: .main) { response in
            print("upload finished:", response)
        }.responseDecodable { (response: DataResponse<T, AFError>) in
            if let error = response.error {
                print("API Error:", error)
                if let data = response.data {
                    do {
                        let value = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(value))
                    } catch {
                        completion(.failure(NetworkErrorType.couldNotParseJson))
                    }
                    
                } else {
                    completion(.failure(NetworkErrorType.serverError))
                }
                return
            }
            guard let value = response.value else { return }
            completion(.success(value))
        }
    }
    
    class func uploadAttachments<R: Codable, T: Codable>(endUrl endPoint: String, paramsType: R.Type, params: R, attachments: [String: [Data]]?, body: [String: Any]? = nil, images: [Data]?, type: T.Type, completion: @escaping (Result<T, NetworkErrorType>) -> Void) {
        guard NetworkManager.isConnectedToInternet else {
            completion(.failure(NetworkErrorType.noInternet))
            return
        }
        do {
            guard var url = URL(string: String(format: "%@%@", KNetworkConstants.ProductionServer.baseURL, endPoint)) else { return }
            let queryItems = try params.asDictionary().toURLQueryItems()
            var urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = queryItems
            url = try (urlComponents?.asURL())!
            AF.upload(multipartFormData: { multipartFormData in
                if let attachments = attachments {
                    for (key, attachments) in attachments {
                        if key.lowercased().contains("pdf") {
                            attachments.forEach {
                                multipartFormData.append($0, withName: "files", fileName: "files.pdf", mimeType: "application/pdf")
                            }
                        }
                        if key.lowercased().contains("txt") || key.lowercased().contains("doc") || key.lowercased().contains("xls") || key.lowercased().contains("ppt") {
                            attachments.forEach {
                                multipartFormData.append($0, withName: "files", fileName: "files.\(key)", mimeType: "text/plain")
                            }
                        }
                        if key.lowercased().contains("m4a") {
                            multipartFormData.append(URL(fileURLWithPath: key), withName: "file_path", fileName: "files.m4a", mimeType: "audio/mpeg")
                        }
                    }
                }
                if let images = images {
                    images.forEach {
                        multipartFormData.append($0, withName: "files", fileName: "files.jpeg", mimeType: "image/jpg")
                    }
                }
                
            }, to: url, usingThreshold: UInt64.init(), method: .post, headers: HeaderInterceptor.multipartHeaderInterceptor()).uploadProgress(queue: .main) { (_) in }.responseJSON(queue: .main) { (response) in
                print("upload attachments finished:", response)
            }.responseDecodable { (response: DataResponse<T, AFError>) in
                guard NetworkManager.isConnectedToInternet else {
                    completion(.failure(NetworkErrorType.noInternet))
                    return
                }
                if response.error != nil {
                    if let data = response.data {
                        do {
                            let value = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(value))
                        } catch {
                            completion(.failure(NetworkErrorType.couldNotParseJson))
                        }
                        
                    } else {
                        completion(.failure(NetworkErrorType.serverError))
                    }
                    return
                }
                guard let value = response.value else { return }
                completion(.success(value))
            }
        } catch {
            completion(.failure(.catchError))
        }
    }
    
    class func performCustomRequest<R: Codable, T: Codable>(endUrl endPoint: String, paramsType: R.Type, params: R, body: Data, type: T.Type, completion: @escaping (Result<T, NetworkErrorType>) -> Void) {
        guard NetworkManager.isConnectedToInternet else {
            completion(.failure(NetworkErrorType.noInternet))
            return
        }
        do {
            guard var url = URL(string: String(format: "%@%@", KNetworkConstants.ProductionServer.baseURL, endPoint)) else { return }
            let queryItems = try params.asDictionary().toURLQueryItems()
            var urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = queryItems
            url = try (urlComponents?.asURL())!
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            HeaderInterceptor.defaultHeaderInterceptor(fromURLRequest: &request)
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if error != nil {
                    completion(.failure(.serverError))
                    return
                }
                guard let data = data else { print("Empty data"); return }
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.couldNotParseJson))
                }
            }.resume()
            
        } catch {
            completion(.failure(.catchError))
        }
    }
    
    class func loadImage(fromUrl url: URL, callback: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData = try? Data(contentsOf: url)
            if let data = imageData {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        callback(image)
                    }
                    
                }
            }
        }
    }
    
    class func openDocument(fileurl: URL, completion: @escaping (URL?) -> Void) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, options: [.removePreviousFile])
        AF.download(fileurl, to: destination)
            .response { (downloadResponse) in
                completion(downloadResponse.fileURL)
            }
    }
}
