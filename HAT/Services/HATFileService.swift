/**
 * Copyright (C) 2016-2019 Dataswift Ltd
 *
 * SPDX-License-Identifier: MPL2
 *
 * This file is part of the Hub of All Things project (HAT).
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/
 */

import Alamofire
import SwiftyJSON

// MARK: Struct

public struct HATFileService {
    
    // MARK: - Search files
    
    /**
     Searches and returns the files we want
     
     - parameter token: The authorisation token to authenticate with the hat
     - parameter userDomain: The user's HAT domain
     - parameter source: The source of the file. Usually the application name that uploaded the file
     - parameter status: The status of the file, Completed or Deleted. Default value is Completed
     - parameter name: The name of the file, default is ""
     - parameter tags: The tags of the files, default is [""]
     - parameter successCallback: An @escaping ([FileUploadObject]) -> Void function to execute when the server has returned the files we were looking for
     - parameter errorCallBack: An @escaping (HATError) -> Void to execute when something went wrong
     */
    public static func searchFiles(userDomain: String, token: String, source: String, status: String? = "Completed", name: String = "", tags: [String]? = [""], successCallback: @escaping ([HATFileUpload], String?) -> Void, errorCallBack: @escaping (HATError) -> Void) {
        
        let url: String = "https://\(userDomain)/api/v2.6/files/search"
        let headers: [String: String] = ["X-Auth-Token": token]
        
        var parameters: Dictionary <String, Any> = ["source": source,
                                                    "name": name,
                                                    "status": [
                                                        "status": status!,
                                                        "size": 0]]
        if tags! != [""] {
            
            parameters = ["source": source,
                          "name": "",
                          "tags": tags!,
                          "status": [
                            "status": status!,
                            "size": 0]]
        }
        
        HATNetworkHelper.asynchronousRequest(
            url,
            method: .post,
            encoding: Alamofire.JSONEncoding.default,
            contentType: ContentType.json,
            parameters: parameters,
            headers: headers) { response -> Void in
            
                switch response {
                    
                case .failure(let error):
                    
                    if error.localizedDescription == "The request timed out." || error.localizedDescription == "The Internet connection appears to be offline." {
                        
                        errorCallBack(.noInternetConnection)
                    } else {
                        
                        let message: String = NSLocalizedString("Server responded with error", comment: "")
                        errorCallBack(.generalError(message, nil, error, nil))
                    }
                case .success(let result):
                    
                    var images: [HATFileUpload] = []
                    // reload table
                    for image: JSON in result.0.arrayValue {
                        
                        images.append(HATFileUpload(from: image.dictionaryValue))
                    }
                    
                    successCallback(images, token)
                }
        }
    }
    
    // MARK: - Delete File
    
    /**
     Deletes a file, with the specified ID, from the server
     
     - parameter fileID: The ID of the file to delete
     - parameter token: The authorisation token to authenticate with the hat
     - parameter userDomain: The user's HAT domain
     - parameter successCallback: An @escaping (Bool) -> Void function to execute when the file has been deleted
     - parameter errorCallBack: An @escaping (HATError) -> Void to execute when something went wrong
     */
    public static func deleteFile(fileID: String, token: String, userDomain: String, successCallback: @escaping (Bool, String?) -> Void, errorCallBack: @escaping (HATError) -> Void) {
        
        let url: String = "https://\(userDomain)/api/v2.6/files/file/\(fileID)"
        let headers: [String: String] = ["X-Auth-Token": token]
        
        HATNetworkHelper.asynchronousRequest(
            url,
            method: .delete,
            encoding: Alamofire.URLEncoding.default,
            contentType: ContentType.json,
            parameters: [:],
            headers: headers) { response -> Void in

                switch response {
                    
                case .failure(let error):
                    
                    if error.localizedDescription == "The request timed out." || error.localizedDescription == "The Internet connection appears to be offline." {
                        
                        errorCallBack(.noInternetConnection)
                    } else {
                        
                        let message: String = NSLocalizedString("Server responded with error", comment: "")
                        errorCallBack(.generalError(message, nil, error, nil))
                    }
                case .success(let result):
                    
                    successCallback(true, result.1)
                }
        }
    }
    
    // MARK: - Change File to Public or Private
    
    /**
     Makes an already uploaded file public
     
     - parameter fileID: The ID of the file to change
     - parameter token: The authorisation token to authenticate with the hat
     - parameter userDomain: The user's HAT domain
     - parameter successCallback: An @escaping (Bool) -> Void function to execute when the file has been made public
     - parameter errorCallBack: An @escaping (HATError) -> Void to execute when something went wrong
     */
    public static func makeFilePublic(fileID: String, token: String, userDomain: String, successCallback: @escaping (Bool) -> Void, errorCallBack: @escaping (HATError) -> Void) {
        
        let url: String = "https://\(userDomain)/api/v2.6/files/allowAccessPublic/\(fileID)"
        let headers: [String: String] = ["X-Auth-Token": token]
        
        HATNetworkHelper.asynchronousRequest(
            url,
            method: .get,
            encoding: Alamofire.URLEncoding.default,
            contentType: ContentType.json,
            parameters: [:],
            headers: headers) { response -> Void in

                switch response {
                    
                case .failure(let error):
                    
                    if error.localizedDescription == "The request timed out." || error.localizedDescription == "The Internet connection appears to be offline." {
                        
                        errorCallBack(.noInternetConnection)
                    } else {
                        
                        let message: String = NSLocalizedString("Server responded with error", comment: "")
                        errorCallBack(.generalError(message, nil, error, nil))
                    }
                case .success:
                    
                    successCallback(true)
                }
        }
    }
    
    /**
     Makes an already uploaded file private
     
     - parameter fileID: The ID of the file to change
     - parameter token: The authorisation token to authenticate with the hat
     - parameter userDomain: The user's HAT domain
     - parameter successCallback: An @escaping (Bool) -> Void function to execute when the file has been made private
     - parameter errorCallBack: An @escaping (HATError) -> Void to execute when something went wrong
     */
    public static func makeFilePrivate(fileID: String, token: String, userDomain: String, successCallback: @escaping (Bool) -> Void, errorCallBack: @escaping (HATError) -> Void) {
        
        let url: String = "https://\(userDomain)/api/v2.6/files/restrictAccessPublic/\(fileID)"
        let headers: [String: String] = ["X-Auth-Token": token]
        
        HATNetworkHelper.asynchronousRequest(
            url,
            method: .get,
            encoding: Alamofire.URLEncoding.default,
            contentType: ContentType.json,
            parameters: [:],
            headers: headers) { response -> Void in

                switch response {
                    
                case .failure(let error):
                    
                    if error.localizedDescription == "The request timed out." || error.localizedDescription == "The Internet connection appears to be offline." {
                        
                        errorCallBack(.noInternetConnection)
                    } else {
                        
                        let message: String = NSLocalizedString("Server responded with error", comment: "")
                        errorCallBack(.generalError(message, nil, error, nil))
                    }
                case .success:
                    
                    successCallback(true)
                }
        }
    }
    
    // MARK: - Complete Upload File to hat
    
    /**
     Completes an upload of a file to hat
     
     - parameter fileID: The fileID of the file uploaded to hat
     - parameter token: The owner's token
     - parameter tags: An array of strings having the tags to add to the file
     - parameter userDomain: The user hat domain
     - parameter completion: A function to execute on success, returning the object returned from the server
     - parameter errorCallback: A function to execute on failure, returning an error
     */
    public static func completeUploadFileToHAT(fileID: String, token: String, tags: [String], userDomain: String, completion: @escaping (HATFileUpload, String?) -> Void, errorCallback: @escaping (HATTableError) -> Void) {
        
        // create the url
        let uploadURL: String = "https://\(userDomain)/api/v2.6/files/file/\(fileID)/complete"
        
        // create parameters and headers
        let header: [String: String] = ["X-Auth-Token": token]
        
        // make async request
        HATNetworkHelper.asynchronousRequest(
            uploadURL,
            method: HTTPMethod.put,
            encoding: Alamofire.JSONEncoding.default,
            contentType: "application/json",
            parameters: [:],
            headers: header) {(response: Result<(JSON, String?)>) -> Void in
                
                switch response {
                    
                case .failure(let error):
                    
                    if error.localizedDescription == "The request timed out." || error.localizedDescription == "The Internet connection appears to be offline." {
                        
                        errorCallback(.noInternetConnection)
                    } else {
                        
                        let message: String = NSLocalizedString("Server responded with error", comment: "")
                        errorCallback(.generalError(message, nil, error, nil))
                    }
                case .success(let result):
                    
                    var fileUploadJSON: HATFileUpload = HATFileUpload(from: result.0.dictionaryValue)
                    fileUploadJSON.tags = tags
                    completion(fileUploadJSON, result.1)
                }
        }
    }
    
    // MARK: - Upload File to hat
    
    /**
     Uploads a file to hat
     
     - parameter fileName: The file name of the file to be uploaded
     - parameter token: The owner's token
     - parameter userDomain: The user hat domain
     - parameter tags: The tags to attach to the file
     - parameter completion: A function to execute on success, returning the object returned from the server
     - parameter errorCallback: A function to execute on failure, returning an error
     */
    public static func uploadFileToHAT(fileName: String, token: String, userDomain: String, tags: [String], completion: @escaping (HATFileUpload, String?) -> Void, errorCallback: @escaping (HATTableError) -> Void) {
        
        // create the url
        let uploadURL: String = "https://\(userDomain)/api/v2.6/files/upload"
        
        // create parameters and headers
        let parameters: Dictionary<String, Any> = HATJSONHelper.createFileUploadingJSONFrom(fileName: fileName, tags: tags)
        let header: [String: String] = ["X-Auth-Token": token]
        
        // make async request
        HATNetworkHelper.asynchronousRequest(
            uploadURL,
            method: HTTPMethod.post,
            encoding: Alamofire.JSONEncoding.default,
            contentType: "application/json",
            parameters: parameters,
            headers: header) {(response: Result<(JSON, String?)>) -> Void in
                
                switch response {
                    
                case .failure(let error):
                    
                    if error.localizedDescription == "The request timed out." || error.localizedDescription == "The Internet connection appears to be offline." {
                        
                        errorCallback(.noInternetConnection)
                    } else {
                        
                        let message: String = NSLocalizedString("Server responded with error", comment: "")
                        errorCallback(.generalError(message, nil, error, nil))
                    }
                case .success(let result):
                    
                    let fileUploadJSON: HATFileUpload = HATFileUpload(from: result.0.dictionaryValue)
                    completion(fileUploadJSON, result.1)
                }
        }
    }
    
    // MARK: - Update Tags
    
    /**
     Updates the tags and name of a file
     
     - parameter fileID: The file id of the file
     - parameter fileName: The file name of the file
     - parameter token: The owner's token
     - parameter userDomain: The user hat domain
     - parameter tags: The tags of the file
     - parameter completion: A function to execute on success, returning the object returned from the server
     - parameter errorCallback: A function to execute on failure, returning an error
     */
    public static func updateParametersOfFile(fileID: String, fileName: String, token: String, userDomain: String, tags: [String], completion: @escaping (HATFileUpload, String?) -> Void, errorCallback: @escaping (HATTableError) -> Void) {
        
        // create the url
        let updateURL: String = "https://\(userDomain)/api/v2.6/files/file/\(fileID)"
        
        // create parameters and headers
        let parameters: Dictionary<String, Any> = HATJSONHelper.createFileUploadingJSONFrom(fileName: fileName, tags: tags)
        let header: [String: String] = ["X-Auth-Token": token]
        
        // make async request
        HATNetworkHelper.asynchronousRequest(
            updateURL,
            method: HTTPMethod.put,
            encoding: Alamofire.JSONEncoding.default,
            contentType: "application/json",
            parameters: parameters,
            headers: header) {(response: Result<(JSON, String?)>) -> Void in
                
                switch response {
                    
                case .failure(let error):
                    
                    if error.localizedDescription == "The request timed out." || error.localizedDescription == "The Internet connection appears to be offline." {
                        
                        errorCallback(.noInternetConnection)
                    } else {
                        
                        let message: String = NSLocalizedString("Server responded with error", comment: "")
                        errorCallback(.generalError(message, nil, error, nil))
                    }
                case .success(let result):
                    
                    let fileUploadJSON: HATFileUpload = HATFileUpload(from: result.0.dictionaryValue)
                    completion(fileUploadJSON, result.1)
                }
        }
    }
    
    // MARK: - Upload file to hat wrapper
    
    /**
     Uploads a file to HAT
     
     - parameter token: The user's token
     - parameter userDomain: The user's domain
     - parameter fileToUpload: The image to upload
     - parameter tags: The tags to attach to the image
     - parameter name: The name of the file, defauls it rumpelPhoto
     - parameter progressUpdater: A function to execute on the progress of the upload is moving forward
     - parameter completion: A function to execute on success
     - parameter errorCallBack: A Function to execute on failure
     */
    public static func uploadFileToHATWrapper(token: String, userDomain: String, fileToUpload: UIImage, tags: [String], name: String = "rumpelPhoto", progressUpdater: ((Double) -> Void)?, completion: ((HATFileUpload, String?) -> Void)?, errorCallBack: ((HATTableError) -> Void)?) {
        
        HATFileService.uploadFileToHAT(
            fileName: name,
            token: token,
            userDomain: userDomain,
            tags: tags,
            completion: {fileObject, renewedUserToken -> Void in
                
                let data: Data? = fileToUpload.jpegData(compressionQuality: 1.0)
                let contentType = "image/jpeg"
                HATNetworkHelper.uploadFile(
                    image: data!,
                    url: fileObject.contentURL,
                    contentType: contentType,
                    progressUpdateHandler: {progress -> Void in
                        
                        progressUpdater?(progress)
                    },
                    completion: {_ -> Void in
                        
                        HATFileService.completeUploadFileToHAT(
                            fileID: fileObject.fileID,
                            token: token,
                            tags: tags,
                            userDomain: userDomain,
                            completion: {uploadedFile, renewedUserToken -> Void in
                                
                                var tempFile: HATFileUpload = fileObject
                                tempFile.status.status = uploadedFile.status.status
                                completion?(tempFile, renewedUserToken)
                            },
                            errorCallback: {error -> Void in
                                
                                errorCallBack?(error)
                            }
                        )
                    })
            },
            errorCallback: {error -> Void in
                
                errorCallBack?(error)
            }
        )
    }
}
