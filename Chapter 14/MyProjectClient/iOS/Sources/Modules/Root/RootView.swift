//
//  RootView.swift
//  MyProjectClient
//
//  Created by Tibor Bödecs on 2020. 05. 15..
//

import Foundation
import UIKit
import Combine
import SafariServices
import MyProjectApi

final class RootView: UIViewController, ViewInterface {
    
    var presenter: RootPresenterViewInterface!
    var entity: RootEntity?
    
    weak var tableView: UITableView!
    weak var activityIndicatorView: UIActivityIndicatorView!
    weak var failureButton: UIButton!
    
    var operations: [String: AnyCancellable] = [:]
    
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
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            self.view.centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor),
            self.view.centerYAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor),
        ])
        
        self.activityIndicatorView = activityIndicatorView
        
        let failureButton = UIButton(type: .system)
        failureButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(failureButton)
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: failureButton.leadingAnchor, constant: 8),
            self.view.trailingAnchor.constraint(equalTo: failureButton.trailingAnchor, constant: -8),
            self.view.centerYAnchor.constraint(equalTo: failureButton.centerYAnchor),
            failureButton.heightAnchor.constraint(equalToConstant: 44),
        ])

        self.failureButton = failureButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MyProject"
        self.view.backgroundColor = .systemBackground
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInset = .zero
                
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh))
        
        self.failureButton.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        
        self.presenter.start()
    }
    
    @objc func refresh() {
        self.presenter.reload()
    }
}

extension RootView: RootViewPresenterInterface {

    func displayLoading() {
        self.activityIndicatorView.startAnimating()

        self.failureButton.isHidden = true
        self.tableView.isHidden = true
        self.activityIndicatorView.isHidden = false
    }
    
    func display(_ entity: RootEntity) {
        self.entity = entity
        self.tableView.reloadData()

        self.failureButton.isHidden = true
        self.tableView.isHidden = false
        self.activityIndicatorView.isHidden = true
    }
    
    func display(_ error: Error) {
        self.failureButton.setTitle("Something went wrong, try again.", for: .normal)
        
        self.failureButton.isHidden = false
        self.tableView.isHidden = true
        self.activityIndicatorView.isHidden = true
    }
}

extension RootView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entity?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.entity!.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        let defaultImage = UIImage(named: "Default")!
        cell.titleLabel.text = item.title
        cell.coverView.image = defaultImage

        self.operations["cell-\(indexPath.row)"]?.cancel()
        self.operations["cell-\(indexPath.row)"] = URLSession.shared
            .downloadTaskPublisher(for: item.imageUrl)
            .map { UIImage(contentsOfFile: $0.url.path) ?? defaultImage  }
            .replaceError(with: defaultImage)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: cell.coverView)

        return cell
    }
}

extension RootView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width * 0.7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = self.entity!.items[indexPath.row]
        let vc = SFSafariViewController(url: item.url)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension RootView: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        self.dismiss(animated: true)
    }
}
