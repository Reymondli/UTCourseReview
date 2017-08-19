//
//  AddNewReviewExtension.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-19.
//  Copyright © 2017 ziming li. All rights reserved.
//

import UIKit

// MARK: This extension file deals with uipickerview for Year, Hard, Useful and Interest textField.
extension AddNewReviewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return yearList.count
        } else {
            return ratingList.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
            return String(yearList.reversed()[row])
        } else {
            return String(ratingList[row])
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            yearTextField.text = String(yearList.reversed()[row])
        } else if pickerView.tag == 2 {
            hardTextField.text = String(ratingList[row])
        } else if pickerView.tag == 3 {
            usefulTextField.text = String(ratingList[row])
        } else if pickerView.tag == 4 {
            interestTextField.text = String(ratingList[row])
        }
    }
}

extension AddNewReviewController {
    func createYearPicker() {
        
        let yearPicker = UIPickerView()
        yearPicker.delegate = self
        yearPicker.tag = 1
        
        yearTextField.inputView = yearPicker
        
        //Customizations
        yearPicker.backgroundColor = .white
    }
    
    func createRatePicker() {
        let hardPicker = UIPickerView()
        let usefulPicker = UIPickerView()
        let interestPicker = UIPickerView()
        hardPicker.delegate = self
        usefulPicker.delegate = self
        interestPicker.delegate = self
        hardPicker.tag = 2
        usefulPicker.tag = 3
        interestPicker.tag = 4
        hardTextField.inputView = hardPicker
        usefulTextField.inputView = usefulPicker
        interestTextField.inputView = interestPicker
        hardPicker.backgroundColor = .white
        usefulPicker.backgroundColor = .white
        interestPicker.backgroundColor = .white
    }
    
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .blue
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddNewReviewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        yearTextField.inputAccessoryView = toolBar
        hardTextField.inputAccessoryView = toolBar
        usefulTextField.inputAccessoryView = toolBar
        interestTextField.inputAccessoryView = toolBar
        commentTextView.inputAccessoryView = toolBar
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
