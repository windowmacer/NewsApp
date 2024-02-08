//
//  RealmManager.swift
//  lesson09
//
//  Created by Кирилл Арефьев on 14.09.2023.
//

import Foundation
import RealmSwift

class RealmManager {
	static let shared = RealmManager()
	let realm = try! Realm()
	var notes = [Note]()
	
	init() {
			fetchNotes()
		}
	
	// MARK: - Note
		
		// fetch Note
		private func fetchNotes() {
			let notes = realm.objects(Note.self)
			self.notes = Array(notes)
		}
		
		// add Note
		func addNote(note: Note) {
			try! realm.write({
				realm.add(note)
			})
			fetchNotes()
		}
		
		// delete Note
		func deleteNote(note: Note) {
			if let note = realm.object(ofType: Note.self, forPrimaryKey: note.id) {
				try! realm.write({
					realm.delete(note)
				})
			}
			fetchNotes()
		}
}
