//
//  StationDetailViewController.swift
//  SubwayStation
//
//  Created by HwangByungJo  on 2022/07/07.
//

import UIKit
import SnapKit
import Alamofire

class StationDetailViewController: UIViewController {
  
  private let station: Station
  private var realtimeArrivalList: [StationArrivalDataResponseModel.RealTimeArrival] = []
  
  private let cellIdentifier = "StationDetailCollectionViewCell"
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    return refreshControl
  }()
      
  private lazy var collectionView: UICollectionView = {
    let layout =  UICollectionViewFlowLayout()
    
    layout.estimatedItemSize = CGSize(width: view.frame.width - 32, height: 100.0)
    layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    layout.scrollDirection = .vertical
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemBackground
    collectionView.dataSource = self
    collectionView.register(StationDetailCollectionViewCell.self,
                            forCellWithReuseIdentifier: cellIdentifier)
    collectionView.refreshControl = refreshControl
    return collectionView
  }()
  
  init(station: Station) {
    self.station = station
    super.init(nibName: nil, bundle: nil)
  }
      
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = station.stationName
    
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    fetchData()
  }
}

extension StationDetailViewController {
  
  @objc func fetchData() {
    
    var stationName = station.stationName
    if stationName.hasSuffix("역") {
      stationName.remove(at: stationName.index(before: stationName.endIndex))
    }
    let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName)"
    
    AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
      .responseDecodable(of: StationArrivalDataResponseModel.self) { [weak self] response in
        self?.refreshControl.endRefreshing()
        guard case .success(let data) = response.result else { return }
        
        self?.realtimeArrivalList = data.realtimeArrivalList
        self?.collectionView.reloadData()
      }
      .resume()
  }
}

extension StationDetailViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return realtimeArrivalList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? StationDetailCollectionViewCell else { return UICollectionViewCell() }
    
    let realTimeArrival = realtimeArrivalList[indexPath.row]
    cell.setup(with: realTimeArrival)
    return cell
  }
  
}
