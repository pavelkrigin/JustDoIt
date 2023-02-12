//
//  NewTaskViewController.swift
//  JustDoIt
//
//  Created by Pavel Krigin on 8.2.23..
//

import UIKit

final class NewTaskViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isHidden = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        setupTextView()
    }
 
    @IBOutlet var taskTextView: UITextView!
    
    @IBOutlet var prioritySegmentedControl: UISegmentedControl!
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func doneButtonPresssed() {
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    private func setupTextView() {
        taskTextView.becomeFirstResponder()
        taskTextView.textColor = .white
    }
}

// MARK: - Work with keyboard

extension NewTaskViewController {
    @objc private func keyboardWillShow(with nitification: Notification) {
        
    }
}

