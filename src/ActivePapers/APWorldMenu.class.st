Class {
	#name : #APWorldMenu,
	#superclass : #Object,
	#category : #'ActivePapers-World Menu'
}

{ #category : #'world menu' }
APWorldMenu class >> activePapersCatalogWorldMenuOn: aBuilder [
	<worldMenu>
	| activePapers |
	(aBuilder item: #ActivePapers)
		label: 'ActivePapers';
		order: 10.
	(aBuilder item: #APDocumentation)
		parent: #ActivePapers;
		order: 0;
		label: 'Documentation';
		withSeparatorAfter;
		action: [ GtInspector openOn: APDocumentation  ].
	activePapers := APActivePaper subclasses sort: [ :a :b | a title < b title ].
	activePapers do:
		[ :each |
			(aBuilder item: each name)
				parent: #ActivePapers;
				label: each title;
				action: [ GtInspector openOn: each ] ].
]
