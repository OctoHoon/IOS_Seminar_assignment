
import UIKit

class TableViewCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return "TableViewCell"
    }
    
    private let wordLabel = UILabel()
    private let numLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "TableViewCell")
        
        self.contentView.backgroundColor = .white
        self.wordLabel.textColor = .black
        self.numLabel.textColor = .black
        
        self.contentView.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            wordLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            wordLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            wordLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -145)
        ])
        
        self.contentView.addSubview(numLabel)
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            numLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            numLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            numLabel.leadingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -140)
        ])
    }
    
    func configure(cvm: dataManager, row: Int) {
        
        
        let dateStr = cvm.searchResult?.items[row].pubDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z" // 2020-08-13 16:30
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        

        let convertDate = dateFormatter.date(from: dateStr!) // Date 타입으로 변환
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy년 MM월 dd일" // 2020년 08월 13일 오후 04시 30분
        myDateFormatter.locale = Locale(identifier:"ko_KR") // PM, AM을 언어에 맞게 setting (ex: PM -> 오후)
        let convertStr = myDateFormatter.string(from: convertDate!)
        print(dateStr)
        print(convertDate)

//
//        self.numLabel.text = convertStr
        
        self.numLabel.text = convertStr
        self.numLabel.numberOfLines = 0
        
        self.wordLabel.text = cvm.searchResult?.items[row].title
        self.wordLabel.numberOfLines = 0
//        } else {return}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    private let viewModel: ViewModel
    
    private let tableView = UITableView()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupLayout()
        applyDesign()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
}

extension ViewController {
    private func setupLayout() {
        self.title = "뉴스 헤드라인"
        let searchBar = UISearchBar()
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        searchBar.delegate = self
  
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func applyDesign() {
        self.view.backgroundColor = .white
        
        tableView.backgroundColor = .white
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min (dataManager.shared.searchResult?.items.count ?? 0, 20)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
            
        cell.configure(cvm: dataManager.shared, row: indexPath.row)
//        cell.configure(cvm: viewModel.pairDataSource[indexPath.row])
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataManager.shared.searchText = searchText
        print(searchText)
        if searchText.isEmpty {return}
        LoadSEARCHnewsAPI.shared.requestAPIToNaver(queryValue: searchText)
//        print(dataManager.shared.searchResult?.items[0...2])
        tableView.reloadData()
//        if dataManager.shared.searchResult?.items.count ?? 0 > 0 {
//            print(dataManager.shared.searchResult?.items.count)
//            print(dataManager.shared.searchResult?.items[0].title)
//        print(dataManager.shared.searchResult?.items[0].pubDate)
//            print(dataManager.shared.searchResult?.items[1].title)
//        print(dataManager.shared.searchResult?.items[1].pubDate)}
        
//        else {return}
    }
    
}




//{ //1
//    (articles) in
//
//    if let articles = articles {
//        dataManager.shared.searchResult?.articles = articles //2
//    }
