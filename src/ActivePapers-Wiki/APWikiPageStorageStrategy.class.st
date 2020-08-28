"
!Storage strategy for wiki pages

This class manages access to a wiki (defined by trait ${class:name=TAPWiki}$) from a ${class:name=GtDocument}$ and indirectly from an ${class:name=APWikiLinkAnnotation}$.
"
Class {
	#name : #APWikiPageStorageStrategy,
	#superclass : #GtStorageStrategy,
	#instVars : [
		'container',
		'name'
	],
	#category : #'ActivePapers-Wiki'
}

{ #category : #accessing }
APWikiPageStorageStrategy >> basename [
	"Return a string representing the document filename"
	<return: #String>
	^ self name, '.', GtFileUtilityConstants pillarExtension
]

{ #category : #accessing }
APWikiPageStorageStrategy >> container [
	^ container
]

{ #category : #accessing }
APWikiPageStorageStrategy >> container: aClass [
	container := aClass
]

{ #category : #accessing }
APWikiPageStorageStrategy >> createOrRetrieveWikiPageNamed: aSymbol [
	^ self container createOrRetrieveWikiPageNamed: aSymbol
]

{ #category : #accessing }
APWikiPageStorageStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self container wikiEvaluationReceiverForPage: name
]

{ #category : #testing }
APWikiPageStorageStrategy >> exists [
	<return: #Boolean>
	^ self container isNotNil and: [ self container hasWikiPageNamed: name ]
]

{ #category : #accessing }
APWikiPageStorageStrategy >> name [
	^ name
]

{ #category : #accessing }
APWikiPageStorageStrategy >> name: aSymbol [
	name := aSymbol
]

{ #category : #actions }
APWikiPageStorageStrategy >> read: aGtDocument [ 
	aGtDocument text: (self container wikiPageNamed: name) text
]

{ #category : #accessing }
APWikiPageStorageStrategy >> rootDirectory [
	<return: #FileReference>
	^ FileSystem workingDirectory
]

{ #category : #actions }
APWikiPageStorageStrategy >> save: aGtDocument [
	self store: aGtDocument
]

{ #category : #actions }
APWikiPageStorageStrategy >> store: aGtDocument [
	| text |
	self 
		assert: [ self container notNil ]
		description: [ 'Container must be non-nil to store a document there' ].
	text := aGtDocument text asString.
	self container store: text inWikiPageNamed: name.
	
]

{ #category : #accessing }
APWikiPageStorageStrategy >> wikiPageNamed: aSymbol [
	^ self container wikiPageNamed: aSymbol
]
