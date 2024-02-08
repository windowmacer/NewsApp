//
//  SavedNewsViewController.swift
//  lesson09
//
//  Created by Кирилл Арефьев on 01.09.2023.
//

import UIKit

final class SavedNewsViewController: UIViewController {
	
	// MARK: properties

	private var savedCollection: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = 10
		layout.minimumInteritemSpacing = 10
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		
		let savedCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		savedCollection.register(NewsCollectionCell.self, forCellWithReuseIdentifier: "cell")
		
		savedCollection.backgroundColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
		savedCollection.contentInsetAdjustmentBehavior = .automatic
		
		return savedCollection
	}()
	
	// MARK: function
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .black
		setupViews()
		
		if let tabBar = self.tabBarController?.tabBar {
			tabBar.barTintColor = .black
		}
		
		savedCollection.reloadData()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.savedCollection.reloadData()
	}
	
	func setupViews() {							// добавление элементов на viewController
		setupNavigationBar()
		setupSavedCollection()
		view.addSubview(savedCollection)
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "My saves"
		navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7216146588, alpha: 1)]
		navigationController?.navigationBar.titleTextAttributes  = [.foregroundColor: #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7216146588, alpha: 1)]
		navigationController?.navigationBar.barTintColor = .black
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	private func setupSavedCollection() {		// настройка savedCollection
		savedCollection.dataSource = self
		savedCollection.delegate = self
		savedCollection.frame = view.frame
	}

}

// MARK: - extension

extension SavedNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return RealmManager.shared.notes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionCell
		
		if let imageData = RealmManager.shared.notes[indexPath.row].imageData {
			let image = UIImage(data: imageData)
			cell.imageNews.image = image
		}
		
		cell.getNews(title: RealmManager.shared.notes[indexPath.row].title,
					 author: RealmManager.shared.notes[indexPath.row].author,
					 date: RealmManager.shared.notes[indexPath.row].dateNews,
					 context: RealmManager.shared.notes[indexPath.row].textNews)
		cell.deleteButton()
		
		cell.openClosures = { [weak self] in
			if let controller = self {
				RealmManager.shared.deleteNote(note: RealmManager.shared.notes[indexPath.row])
				controller.savedCollection.reloadData()
			}
		}
		return cell
	}
}

extension SavedNewsViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
			return CGSize(width: UIScreen.main.bounds.width - 40, height: 200)
		}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
			return UIEdgeInsets(top: 10, left: 0, bottom: 60, right: 0)
		}
}


