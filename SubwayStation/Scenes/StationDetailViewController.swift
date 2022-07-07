//
//  StationDetailViewController.swift
//  SubwayStation
//
//  Created by HwangByungJo  on 2022/07/07.
//

import UIKit
import SnapKit

class StationDetailViewController: UIViewController {
  
  private let cellIdentifier = "StationDetailCollectionViewCell"
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    return refreshControl
  }()
  
  @objc func fetchData() {
    print("REFRESH !")
    refreshControl.endRefreshing()
  }
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "왕십리"
    
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension StationDetailViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? StationDetailCollectionViewCell else { return UICollectionViewCell() }
    
    cell.setup()
    return cell
  }
  
}
