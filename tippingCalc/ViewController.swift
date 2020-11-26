//
//  ViewController.swift
//  tippingCalc
//
//  Created by Eric Baker on 11/26/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
//    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onTap(_ sender: Any) {
        print("hello")
        
        view.endEditing(true)
        
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        //get bill amount
        let bill = Double(billField.text!) ?? 0
        
        //caclulate tip
        let tipSegs   = [0.12, 0.16, 0.2]
        let tipSegIdx = tipSegment.selectedSegmentIndex
        let tipSegAmt = tipSegs[tipSegIdx]
        
        let tip   = bill * tipSegAmt
        let total = bill + tip
        
        //update bill and total label
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        print(darkModeSwitch.isOn)
        
    }

}

