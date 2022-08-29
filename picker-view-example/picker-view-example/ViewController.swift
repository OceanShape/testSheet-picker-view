import UIKit

class ViewController: UIViewController {

    let month = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
    let currentDateComponents = Calendar.current.dateComponents([.year], from: Date())

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

    // DataSource 관련 메서드
    
    // 넣을 열의 개수(ex. 3을 반환할 경우, 3개의 선택할 수 있는 UI가 생긴다)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    // 각 열 별로 선택할 수 있는 개수를 지정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 100
        case 1:
            return 12
        case 2:
            return 31
        default:
            return 0
        }
    }
    
    // Delegate 관련 메서드
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(self.currentDateComponents.year! - row)
        case 1:
            return month[row]
        case 2:
            var component = DateComponents()
            component.year = pickerView.selectedRow(inComponent: 0)
            component.month = pickerView.selectedRow(inComponent: 1)
            component.day = 1
            
            let year = (component.year ?? 0 > 0) ? component.year : 0
            var date = Calendar.current.date(from: component)
            print(date)

            print(Calendar.current.date(byAdding: DateComponents(day: -1), to: date!))
            return "NONE"
        default:
            return "NONE"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.pickedContentLabel.text = data[row]
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
