Extension { #name : #GtClassCommentStrategy }

{ #category : #'*ActivePapers-Wiki' }
GtClassCommentStrategy >> createOrRetrieveWikiPageNamed: aSymbol [
	^ [ self evaluationReceiver createOrRetrieveWikiPageNamed: aSymbol ]
		on: Error do: [ nil ]
]

{ #category : #'*ActivePapers-Wiki' }
GtClassCommentStrategy >> wikiPageNamed: aSymbol [
	^ [ self evaluationReceiver wikiPageNamed: aSymbol ]
		on: Error do: [ nil ]
]
