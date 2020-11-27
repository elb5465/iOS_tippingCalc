//
//  PopUpViewController.swift
//  tippingCalc
//
//  Created by Eric Baker on 11/26/20.
//
//
import UIKit
import SwiftUI

class PopUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(data[row]) + "%"
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: String(data[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }

    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    let data = Array(stride(from: 0, to: 101, by: 1))
    var darkModeObserver: NSObjectProtocol?
    var isDark = false

    override func viewDidLoad() {
        super.viewDidLoad()
    
        picker.dataSource = self
        picker.delegate = self

        saveButtonOutlet.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        cancelButtonOutlet.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
        

//         SETTING A NOTIFICATION LISTENER FOR DARK MODE
        darkModeObserver = NotificationCenter.default.addObserver(forName: Notification.Name("darkMode"), object: nil, queue: .main, using: { [self] notification in
            // RECEIVING A CUSTOM VALUE
            guard let object = notification.object as? [String: String] else { return }
            guard let value = object["mode"] else { return }

            print(value)

            // SET COLORS BASED ON MODE RECEIVED
            if (value == "dark"){
                isDark = true
                print("dark statement executed...")
                self.checkDarkMode(self)
            }

            if (value == "light"){
                isDark = false
            }
        })
        self.checkDarkMode(self)

    }
    

    @IBAction func checkDarkMode(_ sender: Any) {
        if isDark{
            picker.backgroundColor = .darkGray
            picker.tintColor = .white
            saveButtonOutlet.setTitleColor(.white, for: .normal)
            cancelButtonOutlet.setTitleColor(.white, for: .normal)
            self.view.backgroundColor = .red
            print("checkdarkmode STATEMENT executed...")
        }
        print("checkdarkmode fucntion executed...")

    }
    
    @objc private func didTapSaveButton(){
        
        // GET VALUE THAT IS SELECTED IN PICKER
        let selectedValue = pickerView(picker, titleForRow: picker.selectedRow(inComponent: 0), forComponent: 0)
        print(selectedValue ?? "xx")
        
        // SAVE VALUE AND SEND AS NOTIFICATION TO OTHER VIEW
        NotificationCenter.default.post(name: Notification.Name("customTipValue"), object: ["value": selectedValue])

        // DISMISS POP-UP WHEN FINISHED TO RETURN TO ORIGINAL VIEW
        dismiss(animated: true, completion: nil)
        
    }
 
    
    @objc private func didTapCancelButton(){
//        NotificationCenter.default.post(name: Notification.Name("someString"), object: ["color": UIColor.blue])
        dismiss(animated: true, completion: nil)
    }
}

