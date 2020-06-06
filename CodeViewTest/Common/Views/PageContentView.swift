//
//  PageContentView.swift
//  CodeViewTest
//
//  Created by 刘军 on 2020/6/4.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit

private let cellID = "ContentCell"

class PageContentView: UIView {
    private var childVCs: [UIViewController] = []
    private var parentVC: UIViewController
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        //scrollview国情三元素
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.isPagingEnabled = true//scrollView做分页功能必备
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        return collectionView
    }()
    
    init(frame:CGRect,childVCs: [UIViewController],parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PageContentView{
    private func setupUI(){
        for childVC in childVCs{
            parentVC.addChild(childVC)
            childVC.didMove(toParent: parentVC)
        }
        
        addSubview(collectionView)
    }
}

extension PageContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        //因循环添加，需先移除子视图吗？
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
    
}

extension PageContentView: UICollectionViewDelegate{
    
}
