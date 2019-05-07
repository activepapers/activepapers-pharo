Extension { #name : #GtClassCommentStrategy }

{ #category : #'*ActivePapers' }
GtClassCommentStrategy >> createOrRetrieveWikiPageNamed: aSymbol [
	^ [ self evaluationReceiver createOrRetrieveWikiPageNamed: aSymbol ]
		on: Error do: [ nil ]
]

{ #category : #'*ActivePapers' }
GtClassCommentStrategy >> wikiPageNamed: aSymbol [
	^ [ self evaluationReceiver wikiPageNamed: aSymbol ]
		on: Error do: [ nil ]
]
