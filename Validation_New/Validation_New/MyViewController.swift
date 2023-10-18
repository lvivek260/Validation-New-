//
//  ViewController.swift
//  Validation_New
//
//  Created by PHN MAC 1 on 13/10/23.
//

import UIKit

class MyViewController: UIViewController {
// MARK: - IBOutlets
    // TextFields
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    // Warning Labels
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmailId: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    // dependant on
    let restrictCharacter = RestrictCharacter()
    let validation = ValidationManager()
    let pickerView = UIPickerView()
    let toolBar: UIToolbar = UIToolbar()
    
    var ages: [String] = []
    
    
// MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfiguration()
        createToolBar()
        setData()
    }
    private func setData(){
        for i in 1...120{
            ages.append(String(i))
        }
        pickerView.reloadAllComponents()
    }
    
// MARK: - IBActions
    @IBAction func validateButtonClick(_ sender: Any) {
        //Validate Here
        if checkValidation(){
            //navigate on second Screen
        }
    }
    
}

// MARK: - Configurations
extension MyViewController{
    private func uiConfiguration(){
        //Set by Default nil Warning
        lblUserName.text = ""
        lblEmailId.text = ""
        lblMobileNumber.text = ""
        lblAge.text = ""
        lblPassword.text = ""
        //set TextField Delegate
        txtUserName.delegate = self
        txtEmailId.delegate = self
        txtMobileNumber.delegate = self
        txtAge.delegate = self
        txtPassword.delegate = self
        //set Picker View
        pickerView.dataSource = self
        pickerView.delegate = self
        txtAge.inputView = pickerView
        txtAge.inputAccessoryView = self.toolBar
    }
    
    //Keyboard Tool Bar
    private func createToolBar(){
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancleBtnClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnClick))
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: false)
    }
    @objc func cancleBtnClick(){
        self.view.endEditing(true)
    }
    @objc func doneBtnClick(){
        let index = pickerView.selectedRow(inComponent: 0)
        txtAge.text = ages[index]
        self.view.endEditing(true)
    }
    
    //Check Validation for All TextFields
    private func checkValidation()->Bool{
       let name = validation.name(txtUserName.text)
       let email = validation.email(txtEmailId.text)
       let number = validation.mobileNumber(txtMobileNumber.text)
       let age = validation.age(txtAge.text)
       let password = validation.password(txtPassword.text)
        //set Warning message
        lblUserName.text = name.error
        lblEmailId.text = email.error
        lblMobileNumber.text = number.error
        lblAge.text = age.error
        lblPassword.text = password.error
        return name.isSuccess && email.isSuccess && number.isSuccess && password.isSuccess && age.isSuccess
    }
}

// MARK: - UITextField Delegate
extension MyViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let txtString = textField.text ?? ""
        switch textField{
        case txtUserName :
            return restrictCharacter.onlyAlphabet(string: string)
        case txtMobileNumber :
            return restrictCharacter.onlyNumber(string: string, maxNumber: 10, txtString: txtString, range: range)
        case txtAge :
            return false
        default:
            return true
        }
    }
}

// MARK: - Picker View Delegate and DataSource
extension MyViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ages[row]
    }
}

