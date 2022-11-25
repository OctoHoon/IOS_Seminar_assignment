import UIKit

class addTodoViewController: UIViewController, UITextFieldDelegate {
    
    let todoField = UITextField()
    let addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "할 일 추가"
        self.view.backgroundColor = .white
        self.view.addSubview(todoField)
        self.view.addSubview(addButton)
        
        self.todoFieldLayout()
        self.addButtonLayout()
    }
    
    func todoFieldLayout() {
        todoField.translatesAutoresizingMaskIntoConstraints = false
        todoField.borderStyle = .bezel
        todoField.clearButtonMode = .always
        NSLayoutConstraint.activate([
            todoField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            todoField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            todoField.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40)])
        todoField.delegate = self
        
    }
    
    func addButtonLayout() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            addButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            addButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            addButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .purple
        
        addButton.addTarget(self, action: #selector(self.add), for: .touchUpInside)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           guard textField.text!.count < 20 else { return false }
           return true
       }
    
    @objc func add() {
        guard let content = todoField.text else {return}
        if content.count < 1 { return }
        let todo = Todo(content: content, checked: false)
        todos.append(todo)
        let encoder = JSONEncoder()
              if let encoded = try? encoder.encode(todos){
                 UserDefaults.standard.set(encoded, forKey: "Todos")
              }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
