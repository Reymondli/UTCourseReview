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
    @IBOutlet weak var postIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var courseTitle: String!
    var yearList = [String]()
    var yearMin = 2007
    let ratingList = ["","5","4","3","2","1"]

    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        postIndicator.isHidden = true
        courseTitleLabel.text = courseTitle
        configDelegate()
        
        // Config UIPickerView
        createYearPicker()
        createRatePicker()
        createToolbar()
        
        while yearMin <= CurrentYear() {
            yearList.append(String(yearMin))
            yearMin = yearMin + 1
        }
        yearList.append("")
    }
    
    // MARK: Actions
    @IBAction func submitPressed(_ sender: Any) {
        turnOnIndicator(Indicator: postIndicator, turnOn: true)
        // Check Any Empty Field
        if checkEmpty(textField: profTextField) || checkEmpty(textField: yearTextField) || checkEmpty(textField: hardTextField) || checkEmpty(textField: usefulTextField) || checkEmpty(textField: interestTextField) || commentTextView.text.isEmpty {
            turnOnIndicator(Indicator: postIndicator, turnOn: false)
            displayAlert(message: "Please Enter All Fields before Submit", title: "Wait a Second...")
            return
        }
        
        // Check Year
        if Int(yearTextField.text!)! < 2007 || Int(yearTextField.text!)! > CurrentYear() {
            turnOnIndicator(Indicator: postIndicator, turnOn: false)
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
                        self.turnOnIndicator(Indicator: self.postIndicator, turnOn: false)
                        self.successAlert(message: "Review Posted", title: "Success!")
                        return
                    } else {
                        self.turnOnIndicator(Indicator: self.postIndicator, turnOn: false)
                        self.displayAlert(message: "\(error!)", title: "Submit Failure!")
                        return
                    }
                }
            }
        } else {
            turnOnIndicator(Indicator: postIndicator, turnOn: false)
            displayAlert(message: "Rating Value(s) should be Integer(s) from 1 -> 5", title: "Invalid Rating Value(s)")
            return
        }
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
        if textView.text == "Please leave your comment about this course here." {
            textView.text = ""
        }
    }
}
