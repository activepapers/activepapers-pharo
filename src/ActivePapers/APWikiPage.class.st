"
!Wiki page

This class represents individual pages in a wiki set up by ${class:name=TAPWiki}$.
"
Class {
	#name : #APWikiPage,
	#superclass : #Object,
	#instVars : [
		'wiki',
		'name',
		'text'
	],
	#category : #'ActivePapers-Wiki'
}

{ #category : #'instance creation' }
APWikiPage class >> wiki: anAPWiki name: aSymbol text: aString [
	^self basicNew
			initializeWithWiki: anAPWiki name: aSymbol text: aString;
			yourself
]

{ #category : #inspecting }
APWikiPage >> asGtDocument [
	^ GtDocument new
					 strategy: (APWikiPageStorageStrategy new container: wiki; name: name);
					 read
]

{ #category : #inspecting }
APWikiPage >> gtActionRemoveFor: anAction [
	<gtAction>
	^ anAction button
			icon: BrGlamorousIcons trash;
			forViewDefinedIn: #gtDocumentFor:;
			priority: 30;
			action: [ :aButton | self remove ]
]

{ #category : #inspecting }
APWikiPage >> gtDocumentFor: aView [
	<gtView>
	| aGtDocument |
	aGtDocument := self asGtDocument.
	^ (aGtDocument gtTextFor: aView)
		title: name;
		priority: -1;
		action: [ :anAction | 
			aGtDocument gtSaveActionFor: anAction ];
		action: [ :anAction | 
			aGtDocument gtShowMarkupActionFor: anAction ]
]

{ #category : #initialization }
APWikiPage >> initializeWithWiki: anAPWiki name: aSymbol text: aString [
	wiki := anAPWiki.
	name := aSymbol.
	text := aString
]

{ #category : #accessing }
APWikiPage >> name [
	^ name
]

{ #category : #printing }
APWikiPage >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(;
			  nextPutAll: name;
			  nextPut: $).

]

{ #category : #deleting }
APWikiPage >> remove [
	wiki removeWikiPageNamed: name
]

{ #category : #persistence }
APWikiPage >> store [
	wiki store: text inWikiPageNamed: name
]

{ #category : #accessing }
APWikiPage >> text [
	^ text
]

{ #category : #accessing }
APWikiPage >> text: anObject [
	text := anObject
]

{ #category : #accessing }
APWikiPage >> wiki [
	^ wiki
]
