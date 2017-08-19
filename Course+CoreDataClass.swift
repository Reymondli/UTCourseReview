//
//  Course+CoreDataClass.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-14.
//  Copyright © 2017 ziming li. All rights reserved.
//

import Foundation
import CoreData

@objc(Course)
public class Course: NSManagedObject {
    // MARK: Initializer
    convenience init(code: String, name: String, context: NSManagedObjectContext) {
        // An EntityDescription is an object that has access to all
        // the information you provided in the Entity part of the model
        // you need it to create an instance of this class.
        if let ent = NSEntityDescription.entity(forEntityName: "Course", in: context) {
            self.init(entity: ent, insertInto: context)
            self.courseCode = code
            self.courseName = name
            print("Course: \(courseCode!) - \(courseName!) Added")
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
