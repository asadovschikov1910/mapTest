//
//  ErrorController.swift
//  mapsTest
//
//  Created by Андрей Садовщиков on 04.10.2020.
//

import Foundation
import UIKit

func showError(errorText: String, view: UIViewController)
{
    let alert = UIAlertController(title: "Ошибка", message:errorText, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: {
        action in
        alert.dismiss(animated: true, completion: nil)
    }))
    view.present(alert, animated: true, completion: nil)
}
