//
//  HomeViewController.swift
//  CodeViewTest
//
//  Created by 刘军 on 2020/6/3.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit

private let titles = ["推荐", "游戏", "娱乐", "趣玩"]


class HomeViewController: UIViewController {
    
    private lazy var pageTitleView: PageTitleView = {
        let frame = CGRect(x: 0, y: kSAInset.top + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        
        let pageTitleView = PageTitleView(frame: frame, titles: titles)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    private lazy var pageContentView: PageContentView = {
        let y = kSAInset.top + kNavigationBarH + kTitleViewH
        let height = kScreenH - kSAInset.top - kNavigationBarH - kTitleViewH
        let frame = CGRect(x: 0, y: y, width: kScreenW, height: height)
        
        var childVCs: [UIViewController] = []
        for _ in 0...3{
            let vc = UIViewController()
            vc.view.backgroundColor = .init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
            childVCs.append(vc)
        }
        let pageContentView = PageContentView(frame: frame, childVCs: childVCs, parentVC: self)
        
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - UI
extension HomeViewController{
    
    private func setupUI(){
        //        automaticallyAdjustsScrollViewInsets = false
        setNaviBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    private func setNaviBar(){
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named: "128"), for: .normal)
        logoBtn.imageView?.contentMode = .scaleAspectFill
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoBtn)
        
        
        let qrItem = UIBarButtonItem(iconName: "qrcode.viewfinder")
        
        let searchItem = UIBarButtonItem(iconName: "magnifyingglass")
        
        let hisItem = UIBarButtonItem(iconName: "clock")
        
        navigationItem.rightBarButtonItems = [hisItem,searchItem,qrItem]
    }
}

// MARK: - pageTitleView的delegate
extension HomeViewController: PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selected Index: Int) {
        
    }
}
