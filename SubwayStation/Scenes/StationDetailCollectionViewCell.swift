//
//  StationDetailCollectionViewCell.swift
//  SubwayStation
//
//  Created by HwangByungJo  on 2022/07/07.
//

import UIKit
import SnapKit


class StationDetailCollectionViewCell: UICollectionViewCell {
  
  private lazy var lineLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  
  private lazy var reminTimeLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .medium)
    return label
  }()
  
  func setup(with realTimeArrival: StationArrivalDataResponseModel.RealTimeArrival) {
    
    layer.cornerRadius = 12
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.4
    layer.shadowRadius = 5
    backgroundColor = .white
        
    [lineLabel, reminTimeLabel].forEach { addSubview($0) }
    
    lineLabel.snp.makeConstraints {
      $0.leading
        .top
        .equalToSuperview().inset(16)
    }
    
    reminTimeLabel.snp.makeConstraints {
      $0.leading.equalTo(lineLabel)
      $0.top.equalTo(lineLabel.snp.bottom).offset(16)
      $0.bottom.equalToSuperview().inset(16)
    }
    
    lineLabel.text = realTimeArrival.line
    reminTimeLabel.text = realTimeArrival.remainTime
  }
}
