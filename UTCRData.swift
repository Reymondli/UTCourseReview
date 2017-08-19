//
//  UTCRData.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-17.
//  Copyright © 2017 ziming li. All rights reserved.
//

import Foundation

// This is the Temporary Data Storage of the App, only use in some case
class UTCRData {
    var courseId: String?
    static var sharedInstance = UTCRData()
}
