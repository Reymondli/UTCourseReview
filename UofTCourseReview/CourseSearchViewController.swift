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
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!

    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchField.delegate = self
        searchField.text = "Enter Course Code Here"
        turnOnIndicator(Indicator: searchIndicator, turnOn: false)
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
        turnOnIndicator(Indicator: searchIndicator, turnOn: true)
        guard searchField.text!.isEmpty == false && searchField.text != "Enter Course Code Here" else {
            turnOnIndicator(Indicator: searchIndicator, turnOn: false)
            displayAlert(message: "Course Code cannot be Empty", title: "Wait a Minute")
            return
        }
        let partialName = searchField.text

        UTCRClient.sharedInstance.getAutoCompleteCourse(partialName: partialName!){ (searchArray, error) in
            // Always Dealing with UI on Main Thread
            DispatchQueue.main.async {
                guard error == nil else {
                    self.turnOnIndicator(Indicator: self.searchIndicator, turnOn: false)
                    self.displayAlert(message: error!, title: "Search Failed!")
                    return
                }
                // print(searchArray!)
                self.turnOnIndicator(Indicator: self.searchIndicator, turnOn: false)
                let autocontroller = self.storyboard?.instantiateViewController(withIdentifier: "autocomplete") as! AutoCompleteViewController
                autocontroller.courseList = searchArray!
                autocontroller.title = "Search Result"
                self.navigationController?.pushViewController(autocontroller, animated: true)
                // self.present(autocontroller, animated: true, completion: nil)
            }
        }
    }
}



