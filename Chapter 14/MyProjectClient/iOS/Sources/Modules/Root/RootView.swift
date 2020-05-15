//
//  RootView.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 15..
//

import Foundation
import UIKit
import SafariServices

final class RootView: UIViewController, ViewInterface {
    
    var presenter: RootPresenterViewInterface!
    
    weak var tableView: UITableView!
    weak var activityIndicatorView: UIActivityIndicatorView!
    weak var failureButton: UIButton!
    
    var items: [String: [String]] = [
        "Originals": ["👽", "🐱", "🐔", "🐶", "🦊", "🐵", "🐼", "🐷", "💩", "🐰","🤖", "🦄"],
        "iOS 11.3": ["🐻", "🐲", "🦁", "💀"],
        "iOS 12": ["🐨", "🐯", "👻", "🦖"],
    ]
    
    override func loadView() {
        super.loadView()
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MyProject"
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInset = .zero

        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh))
        
        self.presenter.start()
    }
    
    @objc func refresh() {
                
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - helpers
    
    func key(for section: Int) -> String {
        let keys = Array(self.items.keys).sorted { first, last -> Bool in
            if first == "Originals" {
                return true
            }
            return first < last
        }
        let key = keys[section]
        return key
    }
    
    func items(in section: Int) -> [String] {
        let key = self.key(for: section)
        return self.items[key]!
    }
    
    func item(at indexPath: IndexPath) -> String {
        let items = self.items(in: indexPath.section)
        return items[indexPath.item]
    }
}

extension RootView: RootViewPresenterInterface {

}


extension RootView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items(in: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.titleLabel.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.key(for: section)
    }
    
}

extension RootView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let urlString = "https://theswiftdev.com/whats-new-in-swift-5-3/"

        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            present(vc, animated: true)
        }
    }
}

extension RootView: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        self.dismiss(animated: true)
    }
}
