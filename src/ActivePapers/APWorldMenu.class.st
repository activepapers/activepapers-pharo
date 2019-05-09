"
The ActivePapers world menu
"
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
		action: [ GtInspector openOn: APDocumentation  ].
	(aBuilder item: #APCatalog)
		parent: #ActivePapers;
		order: 1;
		label: 'ActivePapers catalog';
		action: [ GtInspector openOn: APCatalog new ].

]
