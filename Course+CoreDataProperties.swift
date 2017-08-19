//
//  Course+CoreDataProperties.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-14.
//  Copyright © 2017 ziming li. All rights reserved.
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var courseCode: String?
    @NSManaged public var courseName: String?

}
