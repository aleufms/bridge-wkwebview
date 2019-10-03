//
//  ViewController.swift
//  bridge-wkwebview
//
//  Created by Alessandro Nakamuta on 01/10/19.
//  Copyright © 2019 enjoei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var value1TextField: UITextField!
    @IBOutlet weak var value2TextField: UITextField!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calcSegue", let calcViewController = segue.destination as? CalcViewController {
            calcViewController.value1 = value1TextField.text ?? ""
            calcViewController.value2 = value2TextField.text ?? ""

            calcViewController.callback = { [weak self] (value1, value2) in
                self?.value1TextField.text = value1
                self?.value2TextField.text = value2
            }
        }
    }
}
