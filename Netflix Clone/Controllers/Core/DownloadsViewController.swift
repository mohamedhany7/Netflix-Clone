//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 05/01/2023.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var movies: [MovieItem] = [MovieItem]()
    
    let downloadsTable: UITableView = {
        let table = UITableView()
        table.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Downloads", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(downloadsTable)
        downloadsTable.delegate = self
        downloadsTable.dataSource = self
        fetchLocalStorageForDownloads()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloads"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownloads()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadsTable.frame = view.bounds
    }
    
    private func fetchLocalStorageForDownloads(){
        DataManager.shared.fetchMoviesFromDatabase { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.downloadsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: MovieViewModel(titleName: movie.title ?? movie.original_title ?? movie.original_name ?? "untittled", posterURL: movie.poster_path ?? "null", date: movie.release_date ?? "0000-00-00"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            DataManager.shared.deleteMovie(with: movies[indexPath.row]) {[weak self] result in
                switch result{
                case .success():
                    print("Deleted")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}
