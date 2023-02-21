//
//  UIViewController+Ext.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import UIKit

extension UIViewController {
    func showModal(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
