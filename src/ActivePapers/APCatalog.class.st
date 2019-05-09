"
!Catalog of ActivePapers

Keeps an alphabetically sorted list of all subclasses of ${class:name=APActivePaper}$.

"
Class {
	#name : #APCatalog,
	#superclass : #Object,
	#instVars : [
		'activePapers'
	],
	#category : #'ActivePapers-World Menu'
}

{ #category : #inspecting }
APCatalog >> gtTableFor: aView [
	<gtView>
	| columnedListView |
	columnedListView := aView columnedList
		title: 'ActivePapers' translated;
		priority: -1;
		items: [ activePapers ].
	columnedListView column
		title: 'Name';
		matchParent;
		item: [ :each | each name ].
	columnedListView column
		title: 'Title';
		matchParent;
		item: [ :each | each title ].
	^ columnedListView
]

{ #category : #initialization }
APCatalog >> initialize [
	activePapers :=
		APActivePaper subclasses
			sort: [ :a :b | a title < b title ].

]
