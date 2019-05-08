Class {
	#name : #APCatalogWorldMenu,
	#superclass : #Object,
	#category : #'ActivePapers-World Menu'
}

{ #category : #'world menu' }
APCatalogWorldMenu class >> activePapersCatalogWorldMenuOn: aBuilder [
	<worldMenu>
	| menuItem activePapers |
	menuItem := aBuilder item: #ActivePapersCatalog.
	menuItem label: 'ActivePapers'.
	activePapers := APActivePaper subclasses sort: [ :a :b | a title < b title ].
	activePapers do:
		[ :each |
			menuItem with:
				[ (aBuilder item: each name)
						label: each title;
						action: [ GtInspector openOn: each ] ] ].
]
