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
        
        let key = UIResponder.keyboardFrameEndUserInfoKey // Объявляется константа key которая содержит UIResponder.keyboardFrameEndUserInfoKey. Свойство keyboardFrameEndUserInfoKey содержит название ключа для использования в словаре userInfo, который передается с уведомлением о появлении или изменении размера клавиатуры. Этот ключ имеет значение типа CGRect, который определяет размер и положение клавиатуры на экране в момент ее отображения или изменения размера.
        
        guard let keyboardFrame = nitification.userInfo?[key] as? CGRect else { return } // Используя полученный ключ, извлекаем размер клавиатуры из словаря и приводим его к типу CGRect
//        guard nitification.userInfo?[key] is CGRect else { return }
        
        bottomConstraint.constant = keyboardFrame.height // Устанавливаем значение для нижнего констрейнта равное высоте клавиатуры

        
        UIView.animate(withDuration: 0.3) { // Что бы процесс смещения элементов интерфейса происходил анимированно, используем метод animate(withDuration:)

            self.view.layoutIfNeeded() // Метод layoutIfNeeded() запускает процесс смещения элементов в соответствии с новыми значениями нижнего констрейнта.

        }
    }
}

