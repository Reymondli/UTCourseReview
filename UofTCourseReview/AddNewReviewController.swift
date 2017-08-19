//
//  AddNewReviewController.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-17.
//  Copyright © 2017 ziming li. All rights reserved.
//

import UIKit

class AddNewReviewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var profTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var hardTextField: UITextField!
    @IBOutlet weak var usefulTextField: UITextField!
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    // MARK: Properties
    var courseTitle: String!
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        courseTitleLabel.text = courseTitle
        configDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Actions
    @IBAction func submitPressed(_ sender: Any) {
        
        // Check Any Empty Field
        if checkEmpty(textField: profTextField) || checkEmpty(textField: yearTextField) || checkEmpty(textField: hardTextField) || checkEmpty(textField: usefulTextField) || checkEmpty(textField: interestTextField) || commentTextView.text.isEmpty {
            displayAlert(message: "Please Enter All Fields before Submit", title: "Wait a Second...")
            return
        }
        
        // Check Year
        if Int(yearTextField.text!)! < 2007 || Int(yearTextField.text!)! > CurrentYear() {
            displayAlert(message: "Year later than 2007 and no more than current year", title: "Invalid Year")
            return
        }
        
        
        // Check Rating Value
        if checkRatingValue(ratingField: hardTextField) && checkRatingValue(ratingField: usefulTextField) && checkRatingValue(ratingField: interestTextField) {
            let jsonbody = [
                Constants.UTCRParameterKeys.courseId: courseTitle,
                Constants.UTCRParameterKeys.courseYear: yearTextField.text!,
                Constants.UTCRParameterKeys.hardness: Int(hardTextField.text!)!,
                Constants.UTCRParameterKeys.useful: Int(usefulTextField.text!)!,
                Constants.UTCRParameterKeys.interest: Int(interestTextField.text!)!,
                Constants.UTCRParameterKeys.professor: profTextField.text!,
                Constants.UTCRParameterKeys.comment: commentTextView.text
            ] as [String: AnyObject]
            UTCRClient.sharedInstance.postCourseReview(JSONBody: jsonbody) { (success, error) in
                DispatchQueue.main.async {
                    if success! {
                        self.successAlert(message: "Review Posted", title: "Success!")
                        return
                    } else {
                        self.displayAlert(message: "\(error!)", title: "Submit Failure!")
                        return
                    }
                }
            }
        } else {
            displayAlert(message: "Rating Value(s) should be Integer(s) from 1 -> 5", title: "Invalid Rating Value(s)")
            return
        }
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddNewReviewController {
    // Define Some Helper Function for Parsing text field content to UTCR API
    func checkEmpty(textField: UITextField)-> Bool{
        if (textField.text?.isEmpty)! {
            return true
        } else {
            return false
        }
    }
    
    func checkRatingValue(ratingField: UITextField)-> Bool{
        if Int(ratingField.text!)! > 5 || Int(ratingField.text!)! < 1 {
            return false
        } else {
            return true
        }
    }
    
    func CurrentYear()-> Int {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return year
    }
    
    func configDelegate() {
        profTextField.delegate = self
        yearTextField.delegate = self
        hardTextField.delegate = self
        usefulTextField.delegate = self
        interestTextField.delegate = self
        commentTextView.delegate = self
        courseTitleLabel.text = courseTitle
    }
}

extension AddNewReviewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
