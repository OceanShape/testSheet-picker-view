import UIKit

class ViewController: UIViewController {

    let month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let currentDateComponents = Calendar.current.dateComponents([.year], from: Date())
    var dayCount = 31

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
    
    // Component: 피커뷰 카테고리 개수/인덱스
    // row: 카테고리 각 열의 개수/인덱스

    // DataSource 관련 메서드
    
    // 카테고리 개수 지정(ex. 3을 반환할 경우, 3개의 선택할 수 있는 UI가 생긴다)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    // 각 카테고리 별로 선택할 수 있는 개수 지정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 100
        case 1:
            return 12
        case 2:
            return dayCount
        default:
            return 0
        }
    }
    
    // Delegate 관련 메서드

    // 해당 위치의 피커뷰 항목을 선택했을 때, 출력할 내용물 지정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(self.currentDateComponents.year! - row)
        case 1:
            return month[row]
        case 2:
            return String(row + 1)
        default:
            return "NONE"
        }
    }

    // 연, 월이 변경되었을 때, day의 제한을 바꾸어 주는 함수(윤달 포함)
    func changeDayComponent(_ pickerView: UIPickerView) {
        var component = DateComponents()
        component.year = pickerView.selectedRow(inComponent: 0)
        component.month = pickerView.selectedRow(inComponent: 1)
        component.day = 1

        let endDayOfMonth = Calendar.current.date(byAdding: DateComponents(month: 2, day: -1), to: Calendar.current.date(from: component)!)
        dayCount = Calendar.current.component(.day, from: endDayOfMonth!)
        pickerView.reloadComponent(2)
    }

    // 선택이 완료되었을 때, 이벤트를 처리하는 함수
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component < 2 { changeDayComponent(pickerView) }
        let year = self.currentDateComponents.year! -  pickerView.selectedRow(inComponent: 0)
        let month = month[pickerView.selectedRow(inComponent: 1)]
        let day = pickerView.selectedRow(inComponent: 2) + 1
        
        self.pickedContentLabel.text = String(format: "\(month) %d, %d", day, year)
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
