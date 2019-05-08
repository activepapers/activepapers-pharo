Class {
	#name : #APWorldMenu,
	#superclass : #Object,
	#category : #'ActivePapers-World Menu'
}

{ #category : #'world menu' }
APWorldMenu class >> activePapersCatalogWorldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ActivePapersCatalog)
		label: 'ActivePapers catalog';
		action: [ GtInspector openOn: (APActivePaper subclasses sort: [ :a :b | a name < b name ] ) ].
]
