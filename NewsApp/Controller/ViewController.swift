//
//  ViewController.swift
//  lesson09
//
//  Created by Кирилл Арефьев on 01.09.2023.
//

import UIKit
import SDWebImage

final class ViewController: UIViewController {
		
	// MARK: properties
	
	private var arrayNews: [Article] = []
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 10
		layout.minimumInteritemSpacing = 10
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(NewsCollectionCell.self, forCellWithReuseIdentifier: "cell")
		
		collectionView.backgroundColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
		collectionView.contentInsetAdjustmentBehavior = .automatic
		
		return collectionView
	}()
	
	// MARK: function

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		setupViews()
	
		if let tabBar = self.tabBarController?.tabBar {
			tabBar.barTintColor = .black
		}
		
		ManagerAPI.shared.getURL(value: "Apple") { news in
			if let array = news.articles {
				self.arrayNews = array
			}
			self.collectionView.reloadData()
		}
	}
	
	func setupViews() {							// добавление элементов на viewController
		setupNavigationBar()
		setupCollectionView()
		view.addSubview(collectionView)
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "News"
		navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7216146588, alpha: 1)]
		navigationController?.navigationBar.titleTextAttributes  = [.foregroundColor: #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7216146588, alpha: 1)]
		navigationController?.navigationBar.barTintColor = .black
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	private func setupCollectionView() {		// настройка collectionView
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.frame = view.frame
	}
	
}

// MARK: - extension

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		arrayNews.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! NewsCollectionCell
		
				if let imageURL = arrayNews[indexPath.row].urlToImage {
					cell.imageNews.sd_setImage(with: URL(string: imageURL))
				}
		cell.getNews(title: arrayNews[indexPath.row].title,
					 author: arrayNews[indexPath.row].author,
					 date: arrayNews[indexPath.row].publishedAt,
					 context: arrayNews[indexPath.row].description)
		cell.addButton()
		return cell
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			return CGSize(width: UIScreen.main.bounds.width - 40, height: 200)
		}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
			return UIEdgeInsets(top: 10, left: 0, bottom: 60, right: 0)
		}
}
