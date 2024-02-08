//
//  NewsCollectionCell.swift
//  lesson09
//
//  Created by Кирилл Арефьев on 17.09.2023.
//

import UIKit

final class NewsCollectionCell: UICollectionViewCell {
	
	// MARK: properties
	
	private let customView = UIView()
	var imageNews = UIImageView()
	var openClosures: (() -> Void)?
	
	private var titleNews = UILabel()
	private var authorNews = UILabel()
	private var dateNews = UILabel()
	private var contextNews = UILabel()
	
	private var mainStack = UIStackView()
	private var titleHStack = UIStackView()
	private var titleVStack = UIStackView()
	
	private lazy var button: UIButton = {
		let button = UIButton()
			button.setTitle("Save", for: .normal)
			button.setTitleColor(.white, for: .normal)
			button.titleLabel?.font = .boldSystemFont(ofSize: 16)
			button.layer.cornerRadius = 20
			
			return button
		}()
	
	// MARK: function
	
	// Основная функция
	func getNews(title: String?, author: String?, date: String?, context: String?) {
		if let text = title {
			titleNews.text = text
		}
				
		if let text = author {
			authorNews.text = text
		}
				
		if let text = date {
			dateNews.text = text
		}
				
		if let text = context {
			contextNews.text = text
		}
		
		setupText()
		setupCell()
	}
	
	// MARK: Logic UI
	
	private func setupText() {										// установка дизайна текстов
		let textArray = [titleNews, authorNews, dateNews, contextNews]
			
		textArray.forEach { label in
			label.numberOfLines = 0
			label.lineBreakMode = .byWordWrapping
			label.font = .systemFont(ofSize: 12)
			label.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7216146588, alpha: 1)
			label.textAlignment = .left
		}
			
		titleNews.font = .boldSystemFont(ofSize: 16)
		authorNews.textColor = #colorLiteral(red: 0.4901960492, green: 0.4901960492, blue: 0.4901960492, alpha: 1)
		dateNews.textColor = #colorLiteral(red: 0.4901960492, green: 0.4901960492, blue: 0.4901960492, alpha: 1)
		dateNews.textAlignment = .right
		contextNews.textAlignment = .natural
	}
	
	private func setupCell() {  									// подключение компонентов cell
		customView.backgroundColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
		customView.layer.cornerRadius = 15
		constraintsView()
		setupImageView()
		setupMainStack()
	}
	
	private func constraintsView() {
		contentView.addSubview(customView)
		customView.translatesAutoresizingMaskIntoConstraints = false
		setupConstraints()
	}
	
	func setupConstraints() {
			NSLayoutConstraint.activate([
				customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
				customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
				customView.topAnchor.constraint(equalTo: contentView.topAnchor),
				customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
				customView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40)
				
			])
		}
	
	private func setupImageView() {
		customView.addSubview(imageNews)
		imageNews.layer.cornerRadius = 15
		imageNews.clipsToBounds = true
		imageNews.contentMode = .scaleAspectFill
		
		imageNews.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			imageNews.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20),
			imageNews.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
			imageNews.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20),
			imageNews.heightAnchor.constraint(equalToConstant: 200)
		])
	}
	
	private func setupHStack() {
		titleHStack.axis = .horizontal
		titleHStack.alignment = .top
		titleHStack.distribution = .equalSpacing
		
		titleHStack.addArrangedSubview(titleNews)
		titleHStack.addArrangedSubview(dateNews)
	}
	
	private func setupVStack() {
		titleVStack.axis = .vertical
		titleVStack.alignment = .fill
		titleVStack.spacing = 10
		
		titleVStack.addArrangedSubview(titleHStack)
		titleVStack.addArrangedSubview(authorNews)
	}
	
	private func setupConstraintsButton() {
		button.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			button.heightAnchor.constraint(equalToConstant: 40)
		])
	}
	
	private func setupConstraintsMainStack() {
		customView.addSubview(mainStack)
		
		NSLayoutConstraint.activate([
			mainStack.topAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: 20),
			mainStack.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
			mainStack.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20),
			mainStack.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20)
		])
	}
	
	private func setupMainStack() {
		mainStack.axis = .vertical
		mainStack.alignment = .fill
		mainStack.spacing = 10
		
		setupHStack()
		setupVStack()
		mainStack.addArrangedSubview(titleVStack)
		mainStack.addArrangedSubview(contextNews)
		mainStack.addArrangedSubview(button)
		setupConstraintsButton()
		
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		setupConstraintsMainStack()
	}
	
	// MARK: buttonTarget

	func addButton() {
		button.backgroundColor = #colorLiteral(red: 0.741604507, green: 0.5587025285, blue: 0.357947588, alpha: 1)
		button.addTarget(self, action: #selector(touchDownButton), for: .touchDown)
		button.addTarget(self, action: #selector(touchUpInsideButton), for: .touchUpInside)
		button.addTarget(self, action: #selector(touchSaveButton), for: .touchUpInside)
	}
	
	func deleteButton() {
		button.setTitle("Delete", for: .normal)
		button.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
		button.addTarget(self, action: #selector(touchDeleteButton), for: .touchUpInside)
	}
	
	// MARK: @objc selector
	
	@objc private func touchSaveButton() {
		let  note = Note()
		
		if let text = titleNews.text {
			note.title = text
		}
		if let text = authorNews.text {
			note.author = text
		}
		if let text = dateNews.text {
			note.dateNews = text
		}
		if let text = contextNews.text {
			note.textNews = text
		}
		if let image = imageNews.image, let imageData = image.pngData() {
			note.imageData = imageData
		}
		
		RealmManager.shared.addNote(note: note)
	}
	
	@objc private func touchDeleteButton() {
		if let deleteFunc = openClosures {
			deleteFunc()
		}
	}
	
	@objc private func touchDownButton() {
		// Измените внешний вид кнопки при нажатии
		UIView.animate(withDuration: 0.4) {
			self.button.backgroundColor = #colorLiteral(red: 0.6, green: 0.4, blue: 0.2, alpha: 1)
		}
	}

	@objc private func touchUpInsideButton() {
		// Верните внешний вид кнопки к исходному при отпускании
		UIView.animate(withDuration: 0.4) {
			self.button.backgroundColor = #colorLiteral(red: 0.741604507, green: 0.5587025285, blue: 0.357947588, alpha: 1)
		}
	}
	
}
