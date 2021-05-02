Class {
	#name : #ApGtMethodsCoder,
	#superclass : #Object,
	#category : #ActivePapers
}

{ #category : #'as yet unclassified' }
ApGtMethodsCoder class >> forActivePaper: anAPActivePaper [
	^ self new
		forActivePaper: anAPActivePaper;
		yourself
]

{ #category : #'as yet unclassified' }
ApGtMethodsCoder >> forActivePaper: anAPActivePaper [
	| scriptMethods |
	scriptMethods := anAPActivePaper scripts values
	"Scripts that compute multiple datasets appear more than once in the
	dictionary, so we convert to a set to keep only unique entries."
										asSet asArray.
	scriptMethods sort: [ :a :b | a selector <= b selector ].
	self forItems: scriptMethods
]
