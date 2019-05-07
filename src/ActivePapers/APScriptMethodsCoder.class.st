Class {
	#name : #APScriptMethodsCoder,
	#superclass : #GtMethodsCoder,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #'instance creation' }
APScriptMethodsCoder class >> forPaper: anAPActivePaper [
	^ self new
		forPaper: anAPActivePaper;
		yourself
]

{ #category : #initialization }
APScriptMethodsCoder >> forPaper: anAPActivePaper [
	| scriptMethods |
	scriptMethods := anAPActivePaper scripts values
	"Scripts that compute multiple datasets appear more than once in the
	dictionary, so we convert to a set to keep only unique entries."
										asSet asArray.
	scriptMethods sort: [ :a :b | a selector <= b selector ].
	super forMethods: scriptMethods
]

{ #category : #private }
APScriptMethodsCoder >> newMethodCoderFor: aMethod [
	| coder |
	coder := APScriptMethodCoder forMethod: aMethod.
	coder methodsCoder: self.
	coder expanded: false.
	^ coder
]
