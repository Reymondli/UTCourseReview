//
//  UTCRClient.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-13.
//  Copyright © 2017 ziming li. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UTCRClient: NSObject {
    // MARK: Property
    var session = URLSession.shared
    
    // For Auto Completion Method
    var autoSearchArray = [[String: String]]()
    
    // For Get Review Method
    var courseInfo = [String: String]()
    var courseRating = [String: String]()
    var courseReviews = [[String: AnyObject]]()
    
    // MARK: Shared Instance
    static var sharedInstance = UTCRClient()
    
    // MARK: CoreDataStack
    var stack: CoreDataStack {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.stack
    }
    
    // MARK: Get Auto-Complete Course Name
    func getAutoCompleteCourse(partialName: String, completionHandlerForAutoComplete: @escaping (_ courseList: [[String: String]]?, _ error: String?)-> Void) {
        
        let url = Constants.UTCRUrl + Constants.autoComplete + partialName
        taskForGet(url: url){ (data, error) in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request")
                // Connection Error - Error
                completionHandlerForAutoComplete(nil, "Connection Failure")
                return
            }
            
            // parse the data
            let parsedResult: [[String:AnyObject]]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:AnyObject]]
            } catch {
                completionHandlerForAutoComplete(nil, "Could not parse the data as JSON: '\(data!)'")
                return
            }
            
            guard let courseArray = parsedResult else {
                completionHandlerForAutoComplete(nil, "Fail to get courseArray'")
                return
            }
            
            guard courseArray.count > 0  else {
                completionHandlerForAutoComplete(nil, "Course not found!")
                return
            }
            /*
            for courseInfo in courseArray {
                guard let id = courseInfo[Constants.JSONResponseKeys.completeId] as? String, let name = courseInfo[Constants.JSONResponseKeys.completeName] as? String else {
                    print("No ID or Name")
                    return
                }
                self.autoSearchArray[id] = name
            }*/
            self.autoSearchArray = courseArray as! [[String : String]]
            completionHandlerForAutoComplete(self.autoSearchArray, nil)
        }
    }
    
    // MARK: Get Course Review
    func getCourseReview(courseCode: String, completionHandlerForGetReview: @escaping(_ courseInfo: [String: AnyObject]?, _ courseRating: [String: AnyObject]?, _ courseReviews: [[String: AnyObject]]?, _ error: String?)-> Void) {
        
        let url = Constants.UTCRUrl + Constants.getReview + courseCode
        print("URL: \(url)")
        taskForGet(url: url) { (data, error) in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request")
                // Connection Error - Error
                completionHandlerForGetReview(nil, nil, nil, "Connection Failure")
                return
            }
            
            // parse the data
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                completionHandlerForGetReview(nil, nil, nil, "Could not parse the data as JSON: '\(data!)'")
                return
            }
            
            // Add Code, Name and Description into CourseInfo Dictionary
            guard let courseInfoDict = parsedResult[Constants.JSONResponseKeys.courseInfo] as? [String: AnyObject], let courseCode = courseInfoDict[Constants.JSONResponseKeys.courseCode] as? String, let courseName = courseInfoDict[Constants.JSONResponseKeys.courseName] as? String, let courseDescription = courseInfoDict[Constants.JSONResponseKeys.courseDescription] as? String else {
                completionHandlerForGetReview(nil, nil, nil, "Fail to get Course Info Array")
                return
            }
            
            self.courseInfo["code"] = courseCode
            self.courseInfo["name"] = courseName
            self.courseInfo["description"] = courseDescription
            
            // Add Hard, Useful and Interest into courseRating Dictionary
            guard let courseRatingDict = parsedResult[Constants.JSONResponseKeys.courseRating] as? [String: AnyObject], let hard = courseRatingDict[Constants.JSONResponseKeys.averageHard] as? Double, let useful = courseRatingDict[Constants.JSONResponseKeys.averageUseful] as? Double, let interest = courseRatingDict[Constants.JSONResponseKeys.averageInterest] as? Double else {
                completionHandlerForGetReview(nil, nil, nil, "Fail to get Course Rating Array")
                return
            }
            
            self.courseRating["hard"] = String(hard)
            self.courseRating["useful"] = String(useful)
            self.courseRating["interest"] = String(interest)
            
            // Add Reviews Info into courseReview Dictionary Array
            guard let courseReviewArray = parsedResult[Constants.JSONResponseKeys.courseReviews] as? [[String: AnyObject]] else {
                completionHandlerForGetReview(nil, nil, nil, "Fail to get Course Reviews Array")
                return
            }
            
            self.courseReviews = courseReviewArray
            
            completionHandlerForGetReview(self.courseInfo as [String : AnyObject], self.courseRating as [String : AnyObject], self.courseReviews, nil)
        }
    }
    
    // MARK: Post Course Review
    func postCourseReview(JSONBody: [String: AnyObject], completionHandlerForPostReview: @escaping(_ success: Bool?, _ error: String?)-> Void) {
        let url = Constants.UTCRUrl + Constants.postReview
        print("URL: \(url)")
        taskForPost(url: url, jsonbody: JSONBody) { (data, error) in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request")
                // Connection Error - Error
                completionHandlerForPostReview(false, "Connection Failure")
                return
            }
            
            // parse the data
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                completionHandlerForPostReview(false, "Could not parse the data as JSON: '\(data!)'")
                return
            }
            
            guard let statusCode = parsedResult[Constants.JSONResponseKeys.status] as? Int, let errmsg = parsedResult[Constants.JSONResponseKeys.errorMessage] as? String else {
                completionHandlerForPostReview(false, "Status Code or Error Message Not Found")
                return
            }
            
            if statusCode == 0 && errmsg == "" {
                completionHandlerForPostReview(true, nil)
            } else if statusCode == 5 {
                completionHandlerForPostReview(false, "Review has already been submitted. You can only post ONE review for each course.")
            } else {
                completionHandlerForPostReview(false, "Failed to Post Review")
            }
        }
    }
}
