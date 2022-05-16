import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var pickedContent: UILabel!
    
    let data: [String] = ["One", "Two", "Three", "Four", "Five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedContent.text = data[row]
    }

}
