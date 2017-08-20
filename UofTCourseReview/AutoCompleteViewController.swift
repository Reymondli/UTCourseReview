//
//  AutoCompleteViewController.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-16.
//  Copyright © 2017 ziming li. All rights reserved.
//

import UIKit

class AutoCompleteViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var courseList: [[String: String]]!
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
}

extension AutoCompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autocomplete")!
        let course = self.courseList[(indexPath as NSIndexPath).row]
        // Set the Course Code and Course Name
        cell.textLabel?.text = course["_id"]
        cell.detailTextLabel?.text = course["name"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Launch Course Review Page with Selected Course Code
        let reviewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "coursereview") as! CourseReviewViewController
        reviewcontroller.completeCourseId = self.courseList[indexPath.row]["_id"]
        reviewcontroller.courseName = self.courseList[indexPath.row]["name"]
        reviewcontroller.title = self.courseList[indexPath.row]["_id"]
        navigationController?.pushViewController(reviewcontroller, animated: true)
    }

}
