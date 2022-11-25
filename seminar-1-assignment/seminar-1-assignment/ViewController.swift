import UIKit

struct Todo: Codable {
    var content: String
    var checked: Bool
}

var todos = [Todo]()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    
    var rightButton = UIBarButtonItem()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    https://github.com/wafflestudio/seminar-2022/blob/main/ios/seminar1/seminar1-inclass/seminar1/ViewController.swift
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
        
        if let objects = UserDefaults.standard.value(forKey: "Todos") as? Data {
           let decoder = JSONDecoder()
           if let todosDecoded = try? decoder.decode(Array.self, from: objects) as [Todo] {
              todos = todosDecoded
           } else {
              todos = [Todo]()
           }
        } else {
           todos = [Todo]()
        }
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = self.rightButton
        
        self.title = "할 일"
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        self.rightButtonLayout()
        self.navigationItem.rightBarButtonItem = self.rightButton
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let button = checkButton()
        button.indexPath = indexPath.row
        button.backgroundColor = .white
        
        if todos[indexPath.row].checked {

            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            
            let attributeString = NSMutableAttributedString(string: todos[indexPath.row].content)
              attributeString.addAttribute(.strikethroughStyle,
                                            value: NSUnderlineStyle.single.rawValue,
                                            range: NSMakeRange(0, attributeString.length))
            cell.textLabel?.attributedText = attributeString
        } else {

            button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            cell.textLabel?.attributedText = .none
            cell.textLabel?.text = todos[indexPath.row].content
        }

        
        cell.contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            button.trailingAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            button.centerYAnchor.constraint(equalTo: cell.contentView.safeAreaLayoutGuide.centerYAnchor)])
        
        button.addTarget(self, action: #selector(todoComplete(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    
    func rightButtonLayout() {
        rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonPressed))
                      
    }
    
    @objc func buttonPressed() {
        let addTodoViewController = addTodoViewController()
        self.navigationController?.pushViewController(addTodoViewController, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @objc func todoComplete(sender: checkButton) {
        if todos[sender.indexPath].checked {
            todos[sender.indexPath].checked = false
        } else {
            todos[sender.indexPath].checked = true
        }
        let encoder = JSONEncoder()
              if let encoded = try? encoder.encode(todos){
                 UserDefaults.standard.set(encoded, forKey: "Todos")
              }
        tableView.reloadData()
    }
    
    
}

class checkButton:UIButton {
    var indexPath = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.setImage(UIImage(named: "checked"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.setImage(UIImage(named: "checked"), for: .normal)

      }
      
}
