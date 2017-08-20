//
//  DetailViewController.swift
//  UofTCourseReview
//
//  Created by ziming li on 2017-08-17.
//  Copyright © 2017 ziming li. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var courseYearLabel: UILabel!
    @IBOutlet weak var profLabel: UILabel!
    @IBOutlet weak var hardLabel: UILabel!
    @IBOutlet weak var usefulLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var commentView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // MARK: Properties
    var detailArray = [String: AnyObject]()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetail(detailReview: detailArray)
    }
    
    func loadDetail(detailReview: [String: AnyObject]) {
        guard let year = detailReview["year"], let prof = detailReview["prof"], let hard = detailReview["hard"], let useful = detailReview["useful"], let interest = detailReview["interest"], let comment = detailReview["comment"], let date = detailReview["updated_at"] else {
            displayAlert(message: "Failed to Load Detail Review", title: "Error")
            return
        }
        courseTitleLabel.text = detailReview["cid"] as? String
        courseYearLabel.text = "Year: \(year)"
        profLabel.text = "Professor: \(prof)"
        hardLabel.text = "Hard: \(hard)"
        usefulLabel.text = "Useful: \(useful)"
        interestLabel.text = "Interest: \(interest)"
        commentView.text = "Comment: \(comment)"
        dateLabel.text = "Posted on: \(date)"
    }
}
