//
//  ViewController.swift
//  NewsApp
//
//  Created by Dmitriy Stepanov on 18.08.2022.
//
/*
 
 Урок https://www.youtube.com/watch?v=V2IfBdxjWs4

 • API Caller -  https://youtu.be/V2IfBdxjWs4?t=72
 • Model - https://youtu.be/V2IfBdxjWs4?t=368
 • TableView  -  https://youtu.be/V2IfBdxjWs4?t=670
 • CustomCell - https://youtu.be/V2IfBdxjWs4?t=798
 • DetailView - https://youtu.be/V2IfBdxjWs4?t=1698
 
 */



import UIKit

class ViewController: UIViewController {
    
// 1. Содаем таблицу и регистрируем для нее базвую ячейку / а потом обычную ячейку
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifire)
        return table
    }()
    private var viewModles = [NewsTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        view.backgroundColor = .systemBackground
 // 1.A Добавляем ее в
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let article):
                self?.viewModles = article.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title ?? "",
                        subtitle: $0.description ?? "",
                        imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard  let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifire, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
}
