//
//  ViewController.swift
//  TestTableView
//
//  Created by Fernando on 23.05.18.
//  Copyright © 2018 Fernando. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
//    var collectionView: UICollectionView!
    var dataSourceDelegate: QuotesDataSourceDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSourceDelegate = QuotesDataSourceDelegate(quotes: [Quote(author: "Hola", text: "Maria"), Quote(author: "Belleza", text: "Apellido")])
        
        setupQuotesCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    fileprivate func setupQuotesCollectionView() {
        // Do any additional setup after loading the view, typically from a nib.
        
//        let layout = UICollectionViewFlowLayout()
//
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: view.frame.width, height: 100)
//
//        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
//        collectionView.dataSource = dataSource
//
//        collectionView.register(QuoteCell.self, forCellWithReuseIdentifier: String(describing: QuoteCell.self))
//
//        view.addSubview(collectionView)
//
//        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
//        collectionView?.dataSource = dataSourceDelegate
//        collectionView?.delegate = dataSourceDelegate
//        collectionView?.register(QuoteCell.self, forCellWithReuseIdentifier: String(describing: QuoteCell.self))
        
        
    }
    
}


class QuotesDataSourceDelegate: NSObject {
    
    let quotes: [Quote]
    
    init(quotes: [Quote]) {
        self.quotes = quotes
    }
    
}

extension QuotesDataSourceDelegate: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuoteCell.self), for: indexPath) as! QuoteCell
        
        cell.viewModel = QuoteCell.ViewModel.init(quote: quotes[indexPath.item])
        
        return cell
    }
}

extension QuotesDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}


extension QuoteCell {
    
    struct ViewModel {
        let author: String
        let quoteText: String
    }
    
}

extension QuoteCell.ViewModel {
    init(quote: Quote) {
        author = quote.author + "El Mejor"
        quoteText = quote.text + "Yes!"
    }
    
}

class QuoteCell: UICollectionViewCell {
    
    var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.textColor = .red
        return label
    }()
    
    var quoteLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    var viewModel: ViewModel? {
        didSet{
            authorLabel.text = viewModel?.author
            quoteLabel.text = viewModel?.quoteText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(authorLabel)
        addSubview(quoteLabel)
        
//        authorLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor)
        
        authorLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: .zero, size: .init(width: 0, height: 70))
        
        quoteLabel.anchor(top: authorLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
        
    }
    
}

struct Quote {
    let author: String
    let text: String
}
