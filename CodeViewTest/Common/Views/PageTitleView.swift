//
//  PageTitleView.swift
//  CodeViewTest
//
//  Created by 刘军 on 2020/6/4.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: AnyObject {
    func pageTitleView(titleView: PageTitleView, selected Index: Int)
}

class PageTitleView: UIView{
    
    private var titles: [String] = []
    private var titleLabels: [UILabel] = []
    private var preLabelIndex = 0
    weak var delegate: PageTitleViewDelegate?
    
    //子视图1
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        //        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    //子视图2
    private lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - kBottomLineH, width: frame.width, height: kBottomLineH)
        return bottomLine
    }()
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        return scrollLine
    }()
    
    
    init(frame: CGRect ,titles: [String]) {
        self.titles = titles //赋给全局，以后用
        super.init(frame: frame)
        
        //添加view的固定两步
        scrollView.frame = bounds //frame和bounds的区别，若=frame则scrollView原点为本view相对于父视图的原点，会下沉
        addSubview(scrollView)
        addSubview(bottomLine)
        
        //孙视图1
        setupTitleLabels()
        //孙视图2
        setupScrollLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI界面
extension PageTitleView{
    private func setupTitleLabels(){
        
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - kBottomLineH
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            
            //属性
            label.text = title
            label.tag = index
            label.font = .systemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .init(85, 85, 85)
            
            //frame
            label.frame = CGRect(x: labelW * CGFloat(index), y: 0, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    private func setupScrollLine(){
        
        guard let firstLabel = titleLabels.first else{ return }
        firstLabel.textColor = .orange
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
    }
}

// MARK: - 点击titleLabel
extension PageTitleView{
    @objc private func labelTapped(tap: UITapGestureRecognizer){
        let tappedLabel = tap.view as! UILabel
        tappedLabel.textColor = .orange
        
        let preLabel = titleLabels[preLabelIndex]
        preLabel.textColor = .init(85, 85, 85)
        
        preLabelIndex = tappedLabel.tag
        
        let offsetX = CGFloat(tappedLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = offsetX
        }
        
        delegate?.pageTitleView(titleView: self, selected: preLabelIndex)
        
    }
}
