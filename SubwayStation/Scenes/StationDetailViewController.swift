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
  
  private let stationName: String
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
  
  init(stationName: String) {
    self.stationName = stationName
    super.init(nibName: nil, bundle: nil)
  }
      
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = stationName
    
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    fetchData()
  }
}

extension StationDetailViewController {
  
  @objc func fetchData() {
        
    NetworkManager.shared.fetchArrivalData(stationName: stationName) { [weak self] realtimeArrivalList in
      
      self?.refreshControl.endRefreshing()
      self?.realtimeArrivalList = realtimeArrivalList
      self?.collectionView.reloadData()
    }
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
