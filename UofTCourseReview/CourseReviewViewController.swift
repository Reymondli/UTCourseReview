//
//  CourseReviewViewController.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-13.
//  Copyright © 2017 ziming li. All rights reserved.
//

import UIKit
import CoreData

class CourseReviewViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noCommentLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var newCommentButton: UIButton!
    
    // MARK: Properties
    var completeCourseId: String!
    var courseName: String!
    var reviewsList = [[String: AnyObject]]()
    var stack: CoreDataStack {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.stack
    }

    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        UTCRData.sharedInstance.courseId = completeCourseId
    }
    
    override func viewWillAppear(_ animated: Bool) {
        noCommentLabel.isHidden = true
        tableView.isHidden = false
        getReviews(courseCode: UTCRData.sharedInstance.courseId!)
    }
    
    // MARK: Buttons
    /* No Longer Needed as Navigation Controller has been used
    @IBAction func cancelPressed(_ sender: Any) {
        // Unwind Segue to Search Page
        self.performSegue(withIdentifier: "MainController", sender: self)
    }
    */
    
    @IBAction func addToFavorite(_ sender: Any) {
        // Add new course to Favorite... and Core Data takes care of the rest!
        print("Name is: " + courseName)
        print("Code is: " + completeCourseId)
        stack.performBackgroundBatchOperation { (Batch) in
            let nc = Course(code: self.completeCourseId, name: self.courseName, context: Batch)
            print("Just Added New Favorite Course: \(nc)")
            DispatchQueue.main.async {
                self.displayAlert(message: "You can see the course from Favorite Tab", title: "Course Saved!")
                self.favoriteButton.isEnabled = false
                return
            }
        }
    }

    @IBAction func addReviewPressed(_ sender: Any) {
        let addreviewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "addreview") as! AddNewReviewController
        addreviewcontroller.courseTitle = self.completeCourseId
        //self.present(addreviewcontroller, animated: true, completion: nil)
        self.navigationController?.pushViewController(addreviewcontroller, animated: true)
    }
    
    func getReviews(courseCode: String) {
        UTCRClient.sharedInstance.getCourseReview(courseCode: completeCourseId) { (infoDict, ratingDict, reviewsArray, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.displayAlert(message: error!, title: "Getting Review Failed!")
                    return
                }
                
                guard let _ = infoDict?["code"], let name = infoDict?["name"], let desc = infoDict?["description"] else {
                    self.displayAlert(message: "Failed to Load Course Info", title: "Error")
                    return
                }
                
                guard let hard = ratingDict?["hard"], let useful = ratingDict?["useful"], let interest = ratingDict?["interest"] else {
                    self.displayAlert(message: "Failed to Get Course Rating", title: "Error")
                    return
                }
                self.courseName = (name as! String)
                //self.courseLabel.text = (code as! String) + " - " + (name as! String)
                self.courseLabel.text = (name as! String)
                //self.descriptionView.text = "\(desc as! String)"
                self.descriptionView.text = "\(desc as! String) \n\n" + "Hardness: \(Double(hard as! String)!.roundToDecimal(2)) \n" + "Usefulness: \(Double(useful as! String)!.roundToDecimal(2)) \n" + "Interest: \(Double(interest as! String)!.roundToDecimal(2))"
                if (reviewsArray?.count)! > 0 {
                    self.reviewsList = reviewsArray!
                } else {
                    self.tableView.isHidden = true
                    self.noCommentLabel.isHidden = false
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
}

extension CourseReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviews")!
        let rowReview = self.reviewsList[(indexPath.row)]
        // Set the Course Comment and Year
        cell.textLabel?.text = rowReview["comment"] as? String
        cell.detailTextLabel?.text = rowReview["updated_at"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Launch Detail View Page of Selected Comment Row
        let detailcontroller = self.storyboard?.instantiateViewController(withIdentifier: "detailview") as! DetailViewController
        detailcontroller.detailArray = self.reviewsList[indexPath.row]
        // self.present(detailcontroller, animated: true, completion: nil)
        self.navigationController?.pushViewController(detailcontroller, animated: true)
    }
}
