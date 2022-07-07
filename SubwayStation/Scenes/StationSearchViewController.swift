//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by HwangByungJo  on 2022/07/06.
//

import UIKit
import SnapKit

class StationSearchViewController: UIViewController {
  
  private var numberOfCell = 0
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
        
    
    setupNavigationItems()
    setupTableViewLayout()
  }
  
  private func setupNavigationItems() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "지하철 도착 정보"
    let searchController = UISearchController()
    searchController.searchBar.placeholder = "지차헐 역을 입력해 주세요."
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    navigationItem.searchController = searchController
  }
  
  private func setupTableViewLayout() {
    
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension StationSearchViewController: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    numberOfCell = 10
    tableView.reloadData()
    tableView.isHidden = false
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    numberOfCell = 0
    tableView.reloadData()
    tableView.isEditing = true
  }
}

extension StationSearchViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfCell
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell()
    cell.textLabel?.text = "\(indexPath.row)"
    
    return cell
  }
}

extension StationSearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    let vc = StationDetailViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}
