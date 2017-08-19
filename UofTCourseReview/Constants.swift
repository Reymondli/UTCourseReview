//
//  Constants.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-12.
//  Copyright © 2017 ziming li. All rights reserved.
//

import Foundation
// MARK: - Constants

struct Constants {
    
    // MARK: UTCR API URL
    static let UTCRUrl = "http://utcr.flowintent.com/api"
    
    // MARK: Extension of URL for Posting a Review to the Course
    static let postReview = "/review"
    
    // MARK: Extension of URL for Getting a Course's Review
    static let getReview = "/review?cid="
    
    // MARK: Extension of URL for Course Name Auto Complete
    static let autoComplete = "/autocomplete?term="
    
    // MARK: UofT Course Review Website
    static let webLink = "http://utcr.flowintent.com"
    
    // MARK: UTCR Request Headers
    static let UTCRHeaders = [
        //"Accept": "application/json",
        "Content-Type": "application/json; charset=utf-8"
    ]
    
    // MARK: HTTPMethod
    enum Method: String {
        case GET
        case POST
    }
    
    struct UTCRParameterKeys {
        static let courseId = "cid"
        static let courseYear = "year"
        static let hardness = "hard"
        static let useful = "useful"
        static let interest = "interest"
        static let professor = "prof"
        static let comment = "comment"
    }
    
    struct JSONResponseKeys {
        
        // MARK: JSONResponse - Auto Complete
        static let completeId = "_id"
        static let completeName = "name"
        
        // MARK: JSONResponse - Course Info
        static let courseInfo = "CourseInfo"
        static let courseCode = "code"
        static let courseName = "name"
        static let courseDescription = "description"
        
        // MARK: JSONResponse - Course Rating
        static let courseRating = "CourseRating"
        static let averageHard = "hard"
        static let averageUseful = "useful"
        static let averageInterest = "interest"
        
        // MARK: JSONResponse - Course Reviews Get
        static let courseReviews = "CourseReviews"
        static let courseId = "cid"
        static let courseYear = "year"
        static let hardness = "hard"
        static let useful = "useful"
        static let interest = "interest"
        static let professor = "prof"
        static let comment = "comment"
        
        // MARK: JSONResponse - Course Review Post
        static let status = "status"
        static let errorMessage = "errmsg"
    }
}


