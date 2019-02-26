//
//  HorizonScrollerTableViewCell.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/21.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit

class HorizonScrollerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModels: [ScrollerImageViewModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(cellType: ScrollerImageCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension HorizonScrollerTableViewCell: NibIdentifiable, ClassIdentifiable {}

extension HorizonScrollerTableViewCell: ConfigurableCell {
    func configure(with object: Any?) {
        guard let viewModel = object as? HorizontalScrollerViewModel else {
            return
        }
        guard let contents = viewModel.contents as? [ScrollerImageViewModel] else {
            return
        }
        
        viewModels = contents
        heightConstraint.constant = viewModel.itemSize.height
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = viewModel.itemSize
        }
        collectionView.reloadData()
    }
}


extension HorizonScrollerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableNibCell(with: ScrollerImageCollectionViewCell.self, for: indexPath)
        cell.configure(with: viewModels?[indexPath.item])
        return cell
    }
    
}
