//
//  AlertController.swift
//  Teleport
//
//  Created by Майя Калицева on 19.05.2022.
//

import UIKit

enum AlertController {
    
    private static var topViewController: UIViewController? {
        guard let app = UIApplication.shared.delegate as? AppDelegate,
              let window = app.window,
              let topRootVC = window.rootViewController else { return nil }
        var topController = topRootVC
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        guard !(topController is UIAlertController) else { return nil }
        return topController
    }
    
    static func noSalaryInfo(action: @escaping () -> Void) {
        let title = "Sorry, we can't find info about this country"
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) {_ in
            action() }

        alert.addAction(okAction)
        topViewController?.present(alert, animated: true)
    }
}
