"
!ActivePapers playground page

A specialized version of ${class:name=GtPlayPage}$ for running code snippets in the context of an ${class:name=APActivePaper}$. Normally launched via ${method:name=APActivePaper class>>#gtActionPlayPageFor:}$.

Code snippets in an APPlayPage are represented by ${class:name=APCoderSnippet}$.
"
Class {
	#name : #APPlayPage,
	#superclass : #GtPlayPage,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #inspecting }
APPlayPage >> gtRunAllActionFor: anAction [
	<gtAction>
	^ anAction button
			icon: BrGlamorousIcons play;
			priority: 1;
			action: [ :aButton | self playAll ] 

]

{ #category : #inspecting }
APPlayPage >> gtViewsFor: aView inContext: aContext [
	"Show a single live view with a title"
	| name playPageView |
	name := self bindings receiver class name.
	playPageView :=
		aView explicit
			stencil: [self asElement margin: (BlInsets all: 10)];
			labelled: name, ' playground'.
	self gtActions do: [ :action | 
		action isDefaultTarget ifTrue: [ 
			playPageView addPhlowAction: action ] ].
	^ playPageView
]

{ #category : #'instance creation' }
APPlayPage >> initialize [
	super initialize.
	bindings := APSnippetBindings new.
]

{ #category : #'instance creation' }
APPlayPage >> newDefaultSnippet [
	"Replace GtCoderSnippet by APCoderSnippet"
	^ APCoderSnippet new.
]

{ #category : #'api - modification' }
APPlayPage >> removeSnippet: aGtSnippet [
	"Overrides GtPlayPage>>removeSnippet:. Change: when the last snippet of a page
	 is removed, replace it by the default snippet rather than a GtCollectionSnippet."

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
	"Overrides GtPlayPage>>snippetBelowRequestedAnnouncement: Change: when adding a new
	 snippet (the + button), don't show a GtCollectionSnippet for selection, but
	 immediately insert the default snippet (which is APCoderSnippet, the only useful
	 one in the context of an APActivePaper)"
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
