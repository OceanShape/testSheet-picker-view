import UIKit

class ViewController: UIViewController {
    
    let data: [String] = ["One", "Two", "Three", "Four", "Five"]
    
    private let pickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let pickedContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .systemRed
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        layoutPickerView()
        
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.addSubview(pickedContentLabel)
        
        NSLayoutConstraint.activate([
            self.pickedContentLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 50),
            self.pickedContentLabel.heightAnchor.constraint(equalToConstant: 50),
            self.pickedContentLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.pickedContentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
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
        self.pickedContentLabel.text = data[row]
    }
    
    func layoutPickerView() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            self.pickerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 200),
            self.pickerView.heightAnchor.constraint(equalToConstant: 200),
            self.pickerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.pickerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }

}
