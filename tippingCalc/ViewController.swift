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
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
//    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var numPplLabel: UILabel!
    @IBOutlet weak var stepperCnt: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func updateNumPeople(_ sender: Any) {
        numPplLabel.text = String(Int(stepperCnt.value))
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
        var perPerson = total

        if (stepperCnt.value > 0){
            perPerson = total / Double(stepperCnt.value)
        }
        
        //update bill and total label
        tipLabel.text       = String(format: "$%.2f", tip)
        totalLabel.text     = String(format: "$%.2f", total)
        perPersonLabel.text = String(format: "$%.2f", perPerson)
    }
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        print(darkModeSwitch.isOn)
        
    }

}

