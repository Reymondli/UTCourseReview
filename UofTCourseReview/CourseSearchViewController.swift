//
//  CourseSearchViewController.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-10.
//  Copyright © 2017 ziming li. All rights reserved.
//

import UIKit

class CourseSearchViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var searchField: UITextField!

    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchField.delegate = self
        searchField.text = "Enter Course Code Here"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        print("Im Back!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - Unwind Segue From Preview Page
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }

    // MARK: Search Pressed
    @IBAction func searchPressed(_ sender: Any) {
        guard searchField.text!.isEmpty == false && searchField.text != "Enter Course Code Here" else {
            displayAlert(message: "Course Code cannot be Empty", title: "Wait a Minute")
            return
        }
        
        let partialName = searchField.text

        UTCRClient.sharedInstance.getAutoCompleteCourse(partialName: partialName!){ (searchArray, error) in
            // Always Dealing with UI on Main Thread
            DispatchQueue.main.async {
                guard error == nil else {
                    self.displayAlert(message: error!, title: "Search Failed!")
                    return
                }
                // print(searchArray!)
                let autocontroller = self.storyboard?.instantiateViewController(withIdentifier: "autocomplete") as! AutoCompleteViewController
                autocontroller.courseList = searchArray!
                autocontroller.title = "Search Result"
                self.navigationController?.pushViewController(autocontroller, animated: true)
                // self.present(autocontroller, animated: true, completion: nil)
            }
            
            
            /* --- Test: Get Reviews
            UTCRClient.sharedInstance.getCourseReview(courseCode: (searchArray?[0]["_id"])!){ (info, rating, reviews, error) in
                guard error == nil else {
                    print("Error happens: \(error!)")
                    return
                }
                print("Course Info: \(info!)")
                print("Course Rating: \(rating!)")
                print("COurse Reviews: \(reviews!), isEmpty: \(reviews!.isEmpty)")
            }
            */
        }
        
    /* --- Test: Post Review
        let comment = "This Course Is Critical if you want to stay in hardware or digital electronic area. Professor Phang is really kind."
        let jsonbody = [
            Constants.UTCRParameterKeys.courseId: "ece231h1s",
            Constants.UTCRParameterKeys.courseYear: 2015,
            Constants.UTCRParameterKeys.hardness: 4,
            Constants.UTCRParameterKeys.useful: 5,
            Constants.UTCRParameterKeys.interest: 3,
            Constants.UTCRParameterKeys.professor: "K.Phang",
            Constants.UTCRParameterKeys.comment: comment
            ] as [String: AnyObject]
        
        UTCRClient.sharedInstance.postCourseReview(JSONBody: jsonbody) { (success, error) in
            if success! {
                print("Success!")
            } else {
                print("Error found: \(error!)")
            }
            
        }
    */
    }

}



