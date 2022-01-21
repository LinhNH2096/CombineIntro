//
//  ViewController.swift
//  CombineIntro
//
//  Created by Nguyễn Hồng Lĩnh on 21/01/2022.
//

import UIKit
import Combine

// MARK: - Custom TableViewCell
final class CustomTableViewCell: UITableViewCell {
    
}

// MARK: - My ViewController
final class ViewController: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
        
        return tableView
    }()
    
    private var data = [String]()
    
    private var observer: AnyCancellable? // This guy automatically call cancel() when view deinit. Same as DisposeBag in Rx

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
}
// MARK: - Private Method
private extension ViewController {
    func setup() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
    }
    
    func fetchData() {
       observer = APIService.shared.fetchDummyCompanyName() // -> Future
            .receive(on: DispatchQueue.main) // -> Work on main thread
            .sink { completion in // subcriber
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] values in //
                self?.data = values
                self?.tableView.reloadData()
            }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self),
                                                       for: indexPath)
                as? CustomTableViewCell
        else { fatalError() }
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

