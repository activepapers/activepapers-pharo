"
!Bindings for code snippets in ActivePapers playgrounds

A subclass of ${class:name=GtSnippetBindings}$ that provides access to the data slots of an ${class:name=APActivePaper}$.
"
Class {
	#name : #APSnippetBindings,
	#superclass : #GtSnippetBindings,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #binding }
APSnippetBindings >> bindingOf: aSymbol [
	^ (super bindingOf: aSymbol)
		ifNil: [ self receiver class datasets
						at: aSymbol 
						ifPresent: [ :aValue | aValue ] 
						ifAbsent: [ nil ] ]

]

{ #category : #binding }
APSnippetBindings >> hasBindingOf: aSymbol [
	^ (super hasBindingOf: aSymbol)
		or: [ self receiver class datasets includesKey: aSymbol ]
]
