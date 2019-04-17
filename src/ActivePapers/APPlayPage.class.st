Class {
	#name : #APPlayPage,
	#superclass : #GtPlayPage,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #inspecting }
APPlayPage >> gtViewsFor: aView inContext: aContext [
	| name |
	name := self bindings receiver class name.
	^ aView explicit
		stencil: [self asElement margin: (BlInsets all: 10)];
		labelled: name, ' playground'.

]

{ #category : #'instance creation' }
APPlayPage >> newDefaultSnippet [
	^ APCoderSnippet new.
]

{ #category : #'api - modification' }
APPlayPage >> removeSnippet: aGtSnippet [
	"Replacement for GtPlayPage>>removeSnippet:. Change: when the last snippet of a page
	 is removed, replace it by the default snippet rather than a collection snippet."

	| anIndex |
	self
		assert: [ aGtSnippet notNil ]
		description: [ 'Snippet must be non-nil' ].
	anIndex := self snippets indexOf: aGtSnippet.
	self snippets removeAt: anIndex.
	self detachFromSnippet: aGtSnippet.
	self notifySnippetRemoved: aGtSnippet at: anIndex.
	"Ensure that PlayPage has always one snippet."
	self snippets isEmpty ifTrue: [ self addSnippet: self newDefaultSnippet ].

]

{ #category : #'announcement handling' }
APPlayPage >> snippetBelowRequestedAnnouncement: aGtSnippetBelowRequestedAnnouncement [ 
	| anSnippet anIndex aNewSnippet |
	anSnippet := aGtSnippetBelowRequestedAnnouncement snippet.
	self
		assert: [ anSnippet notNil ] 
		description: [ 'Source snippet for new snippet request must be non-nil' ].
	anIndex := self snippets indexOf: anSnippet.
	aNewSnippet := aGtSnippetBelowRequestedAnnouncement secondSnippet.
	aNewSnippet ifNil: [ aNewSnippet := self newDefaultSnippet ].
	self addSnippet: aNewSnippet at: anIndex + 1.
]
