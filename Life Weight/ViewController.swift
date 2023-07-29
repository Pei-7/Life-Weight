//
//  ViewController.swift
//  Life Weight
//
//  Created by 陳佩琪 on 2023/7/28.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        hourPickerItems.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return
            hourPickerItems[row]
        }
    
    let yearData = Year.data
    let monthData = Month.data
    let dateData = Date.data
    let hourData = Hour.data
    let poemData = Poem.data
    
    @IBOutlet var birthDatePicker: UIDatePicker!
    
    @IBOutlet var hourTextField: UITextField!
    @IBOutlet var hourPickerView: UIPickerView!
    @IBOutlet var hourToolbar: UIToolbar!
    
    var hourPickerItems: [String] = []

    var lifeWeight = 0.0
    
    @IBOutlet var twelveZodiacImageView: UIImageView!
    
    @IBOutlet var resultView: UIView!
    @IBOutlet var poemTitle: UILabel!
    @IBOutlet var poemContent: UITextView!
    @IBOutlet var lunarBirthDate: UILabel!
    @IBOutlet var zodiacImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0...23 {
            let string = String(format: "%02d 時",i)
            hourPickerItems.append(string)
        }
        
        hourTextField.inputView = hourPickerView
        hourTextField.inputAccessoryView = hourToolbar
        
        resultView.isHidden = true
        
    }

    @IBAction func selectHour(_ sender: Any) {
        hourTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelHourPicker(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func doneHourPicker(_ sender: Any) {
        let row = hourPickerView.selectedRow(inComponent: 0)
        hourTextField.text = hourPickerItems[row]
        view.endEditing(true)
    }
    
    
    @IBAction func calculateLifeWeight(_ sender: Any) {
        twelveZodiacImageView.isHidden = true
        resultView.isHidden = false
        
        let birthDate = birthDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .chinese)
        
        dateFormatter.dateFormat = "yy"
        let theYear = dateFormatter.string(from: birthDate)
        
        dateFormatter.dateFormat = "MM"
        let theMonth = dateFormatter.string(from: birthDate)
        
        dateFormatter.dateFormat = "dd"
        let theDay = dateFormatter.string(from: birthDate)
        
        let theHour = hourTextField.text?.prefix(2)
        
        print(theYear,theMonth,theDay,theHour!)

        
        let yearIndex = Int(theYear)
        let monthIndex = Int(theMonth)
        let dateIndex = Int(theDay)
        let hourIndex = Int(theHour ?? "0")
        
        //對照農曆日期
        var birthDateString = ""
        if let index = yearData.firstIndex(where: {$0.year == yearIndex}) {
            print("yearIndex",index)
            zodiacImageView.image = UIImage(named: yearData[index].zodiacImageName)
            birthDateString.append(yearData[index].yearString + "年")
        }
        if let index = monthData.firstIndex(where: {$0.month == monthIndex}) {
            birthDateString.append(monthData[index].monthString)
        }
        if let index = dateData.firstIndex(where: {$0.date == dateIndex}) {
            birthDateString.append(dateData[index].dateString)
        }
        if let index = hourData.firstIndex(where: {$0.hour == hourIndex}) {
            birthDateString.append(hourData[index].hourString)
        }
        lunarBirthDate.text = birthDateString
        

        //計算重量
        if let yearIndex, let monthIndex, let dateIndex, let hourIndex {
            lifeWeight = yearData[yearIndex-1].weight + monthData[monthIndex-1].weight + dateData[dateIndex-1].weight + hourData[hourIndex].weight
        }

        print("lifeWeight",lifeWeight)
        
        if let index = poemData.firstIndex(where: {$0.weight == lifeWeight}) {
            poemTitle.text = poemData[index].title
            poemContent.text = poemData[index].content
                }
        
        

        
    }
    
    
    
    
    
    
}

