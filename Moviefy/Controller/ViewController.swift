//
//  ViewController.swift
//  Moviefy
//
//  Created by Adriana González Martínez on 3/12/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var movies: [Movie] = []
    var collectionView: UICollectionView!
    var sections: [Section] = []
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = UIColor.white
        fetchPopular()
    }
    
    func setupCollectionView() {
        let sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        collectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: MovieCell.identifier, bundle: .main), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(UINib(nibName: TitleCell.identifier, bundle: .main), forCellWithReuseIdentifier: TitleCell.identifier)
        self.view.addSubview(collectionView)
    }
    
    func fetchPopular(){
    
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case is MovieSection:
            let section = sections[indexPath.section] as! MovieSection
            return section.configureCell(collectionView: collectionView, indexPath: indexPath)
        default:
            return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
        }
        
    }
}

extension ViewController: UICollectionViewDelegate {}
