//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by HwangByungJo  on 2022/07/06.
//

import UIKit
import SnapKit
import Alamofire

class StationSearchViewController: UIViewController {
  
  private var stations: [Station] = []
  
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
}

extension StationSearchViewController {
  
  private func setupNavigationItems() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "지하철 도착 정보"
    let searchController = UISearchController()
    searchController.searchBar.placeholder = "지하철 역을 입력해 주세요."
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
  
  private func requsetStaionName(from stationName: String) {
    
    guard !stationName.isEmpty else {
      stations.removeAll()
      return
    }
    
    NetworkManager.shared.fetchSearchData(stationName: stationName) { [weak self] stations in
      self?.stations = stations
      self?.tableView.reloadData()
    }
  }
}

extension StationSearchViewController: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    tableView.reloadData()
    tableView.isHidden = false
  }    
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    tableView.isHidden = true
    stations.removeAll()
    tableView.reloadData()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    requsetStaionName(from: searchText)
  }
}

extension StationSearchViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
  
    let station = stations[indexPath.row]
    cell.textLabel?.text = station.stationName
    cell.detailTextLabel?.text = station.lineNumber
    return cell
  }  
}

extension StationSearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    let station = stations[indexPath.row]
    let vc = StationDetailViewController(stationName: station.stationName)
    navigationController?.pushViewController(vc, animated: true)
  }
}
