//
//  NewTaskViewController.swift
//  JustDoIt
//
//  Created by Pavel Krigin on 8.2.23..
//

import UIKit

final class NewTaskViewController: UIViewController {
 
    @IBOutlet var taskTextView: UITextView!
    
    @IBOutlet var prioritySegmentedControl: UISegmentedControl!
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func doneButtonPresssed(_ sender: Any) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
    }
}


