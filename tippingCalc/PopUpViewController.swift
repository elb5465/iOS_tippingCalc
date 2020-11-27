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

    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    let data = Array(stride(from: 0, to: 101, by: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self

        saveButtonOutlet.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        cancelButtonOutlet.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
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

