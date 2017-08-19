//
//  UTCRConvenience.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-14.
//  Copyright © 2017 ziming li. All rights reserved.
//

import Foundation

extension UTCRClient {
    // MARK: Get Request Method - Auto Complete and Get Review
    func taskForGet(url: String, completionHandlerForGet: @escaping (_ data: Data?, _ error: String?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = Constants.Method.GET.rawValue.uppercased()
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request")
                // Connection Error - Error
                completionHandlerForGet(nil, "Connection Failure")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                // Connection Error - Status Code
                print("Your request returned a status code other than 2xx!")
                completionHandlerForGet(nil, "Invalid Username or Password")
                return
            }
            
            /* GUARD: Was there any data returned? */
            /* subset response data! */
            guard let data = data else {
                print("No data was returned by the request!")
                completionHandlerForGet(nil, "No data returned, please check your username and password")
                return
            }
            completionHandlerForGet(data, nil)
        }
        task.resume()
    }
    
    // MARK: Post Request Method - Post Review
    func taskForPost(url: String, jsonbody: [String: AnyObject], completionHandlerForPost: @escaping(_ data: Data?, _ error: String?)->Void) {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = Constants.Method.POST.rawValue.uppercased()
        for (field, value) in Constants.UTCRHeaders {
            request.setValue(value, forHTTPHeaderField: field)
        }
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonbody, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request")
                // Connection Error - Error
                completionHandlerForPost(nil, "Connection Failure")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                // Connection Error - Status Code
                print("Your request returned a status code other than 2xx!")
                completionHandlerForPost(nil, "Invalid Username or Password")
                return
            }
            
            /* GUARD: Was there any data returned? */
            /* subset response data! */
            guard let data = data else {
                print("No data was returned by the request!")
                completionHandlerForPost(nil, "No data returned, please check your username and password")
                return
            }
            completionHandlerForPost(data, nil)
        }
        task.resume()
    }
    
}
