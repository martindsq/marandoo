//
//  ViewController.swift
//  Marandoo
//
//  Created by Martin Dutra on 1/16/18.
//  Copyright © 2018 Codeshaped. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var toolbarBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        addGestureRecognizers()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }

    private func addGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: textField,
                                                          action: #selector(resignFirstResponder))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let bottomAdditionalSafeAreaInset = keyboardFrame.height - view.safeAreaInsets.bottom

        UIView.animate(withDuration: duration) { [weak self] in
            self?.additionalSafeAreaInsets.bottom = bottomAdditionalSafeAreaInset
            self?.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        let info = notification.userInfo!
        let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let bottomAdditionalSafeAreaInset: CGFloat = 0

        UIView.animate(withDuration: duration) { [weak self] in
            self?.additionalSafeAreaInsets.bottom = bottomAdditionalSafeAreaInset
            self?.view.layoutIfNeeded()
        }
    }

    fileprivate func updateLabel(with string: String?) {
        label.text = string
    }

    fileprivate func clearTextField() {
        textField.text = nil
    }

}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateLabel(with: textField.text)
        clearTextField()
        return true
    }

}
