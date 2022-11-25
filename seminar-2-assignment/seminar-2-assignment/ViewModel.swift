//
//  ViewModel.swift
//  seminar-2-assignment
//
//  Created by 사공훈 on 2022/09/25.
//

import UIKit

struct CellViewModel {
    let word: String
    let num: Int
}

class ViewModel {
    var pairDataSource: [CellViewModel] = [
        CellViewModel(word: "A", num: 1),
        CellViewModel(word: "B", num: 2),
        CellViewModel(word: "C", num: 3),
        CellViewModel(word: "D", num: 4),
        CellViewModel(word: "E", num: 5)
    ]
}

class dataManager {
    static let shared : dataManager = dataManager()
    var searchResult : ArticleList?
    var searchText : String?
    
    private init() {
        
    }
}


struct ArticleList: Codable {

    let items: [Item]
}


struct Item: Codable {
    let title: String
    let pubDate: String
}

class LoadSEARCHnewsAPI {
    
    static var shared = LoadSEARCHnewsAPI()
    
    let jsconDecoder: JSONDecoder = JSONDecoder()

//    func urlTaskDone() {
//          let item = dataManager.shared.searchResult?.items[0]
//        print(item!)
//      }
    
    func requestAPIToNaver(queryValue: String) {
        
        let clientID: String = "w5uz2cxN0moxZEEofR94"
        let clientKEY: String = "wmEEb8UaMX"
        
        let query: String  = "https://openapi.naver.com/v1/search/news.json?query=\(queryValue)&display=100"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
       
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue(clientKEY, forHTTPHeaderField: "X-Naver-Client-Secret")

              
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else { print(error!); return }

            do {
                let searchInfo: ArticleList = try self.jsconDecoder.decode(ArticleList.self, from: data)
                dataManager.shared.searchResult = searchInfo
//                print(searchInfo)
//                self.urlTaskDone()
            } catch {
                print(fatalError())
            }
        }
        task.resume()
    }
}

//        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                completion(nil) // if any error occurs, article can be nil
//            }
//            else if let data = data {
//                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
//                print(articleList)
//                if let articleList = articleList {
//                    completion(articleList.articles)
//                }
//                print(articleList?.articles ?? 0)
//            }
//        }.resume()
//
