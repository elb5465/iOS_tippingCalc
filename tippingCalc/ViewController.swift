//
//  ViewController.swift
//  tippingCalc
//
//  Created by Eric Baker on 11/26/20.
//

import UIKit

// Border radius, shadow, etc. taken from https://spin.atomicobject.com/2017/07/18/swift-interface-builder/

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var navBarHeader: UINavigationItem!
    @IBOutlet weak var cntPplLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var perPersonTextLabel: UILabel!
    @IBOutlet weak var billamtLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var numPplLabel: UILabel!
    @IBOutlet weak var stepperCnt: UIStepper!
    @IBOutlet weak var tipamtLabel: UILabel!
    @IBOutlet weak var darkModeIcon: UIBarButtonItem!
    
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CHANGING THE FONT COLOR FOR THE SEGMENT COMPONENTS
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tipSegment?.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let blacktextAttr = [NSAttributedString.Key.foregroundColor: UIColor.black]
        tipSegment?.setTitleTextAttributes(blacktextAttr, for: .selected)

        self.billField.becomeFirstResponder()
        
        // SETTING A NOTIFICATION LISTENER FOR DATA FROM THE CUSTOM_TIP_POPUP
        observer = NotificationCenter.default.addObserver(forName: Notification.Name("customTipValue"), object: nil, queue: .main, using: { [self] notification in
            
            // RECEIVING A CUSTOM VALUE
            // guard let object = notification.object as? [String: UIColor] else { return }
            guard let object = notification.object as? [String: String] else { return }
            guard let value = object["value"] else { return }
            
            // GET INDEX OF SELECTED SEGMENT
            let selectedIndex = self.tipSegment.selectedSegmentIndex
            
            // UPDATE THAT SEGMENT'S TITLE WITH NEW VALUE
            self.tipSegment.setTitle(value, forSegmentAt: selectedIndex)
            
            // CALL calculateTip TO UPDATE VALUE
            self.calculateTip(self)
        })
        
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func updateNumPeople(_ sender: Any) {
        cntPplLabel.text = String(Int(stepperCnt.value))
    }
    
    
    
    
    
    
    @IBAction func calculateTip(_ sender: Any) {
        //get bill amount
        let bill = Double(billField.text!) ?? 0
        
        //caclulate tip
//        let tipSegs   = [0.12, 0.16, 0.2]
//        let tipSegIdx = tipSegment.selectedSegmentIndex
//        let tipSegAmt = tipSegs[tipSegIdx]
        let selectedSeg = tipSegment.selectedSegmentIndex
        let segTitle = tipSegment.titleForSegment(at: selectedSeg)?.replacingOccurrences(of: "%", with: "") ?? ""
        
        var tipPercentage = Double(segTitle) ?? 1.0
        tipPercentage = tipPercentage / 100
        
        let tip   = bill * tipPercentage
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
        //SAVE ORIGINAL LIGHT VIEW COLORS HERE TO REVERT
        let lightView = UIColor.white
        let lightText = UIColor.black
        
        
        if (darkModeSwitch.isOn){
            view.backgroundColor = UIColor.darkGray
            
            tipLabel.textColor       = UIColor.white
            totalLabel.textColor     = UIColor.white
            numPplLabel.textColor    = UIColor.white
            cntPplLabel.textColor    = UIColor.white
            perPersonLabel.textColor = UIColor.white
            billamtLabel.textColor   = UIColor.white
            tipamtLabel.textColor    = UIColor.white
            totalTextLabel.textColor = UIColor.white
            perPersonTextLabel.textColor = UIColor.white

            navigationController?.navigationBar.barTintColor = UIColor.darkGray
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

            darkModeIcon.tintColor = UIColor.white

            billField.backgroundColor  = UIColor.white
            stepperCnt.backgroundColor = UIColor.white
            
            // SEND AS NOTIFICATION TO OTHER VIEW
            NotificationCenter.default.post(name: Notification.Name("darkMode"), object: ["mode": "dark"])

        }
        
        if (!darkModeSwitch.isOn){
            view.backgroundColor = lightView
            
            tipLabel.textColor       = lightText
            totalLabel.textColor     = lightText
            perPersonLabel.textColor = lightText
            cntPplLabel.textColor    = lightText
            numPplLabel.textColor    = lightText
            billamtLabel.textColor   = lightText
            tipamtLabel.textColor    = lightText
            totalTextLabel.textColor = lightText
            perPersonTextLabel.textColor = lightText
            
            navigationController?.navigationBar.barTintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

            darkModeIcon.tintColor   = UIColor.purple
            darkModeSwitch.tintColor = UIColor.purple

            billField.backgroundColor  = UIColor.white
            stepperCnt.backgroundColor = UIStepper.init().backgroundColor
        }
    }
    
    
}



