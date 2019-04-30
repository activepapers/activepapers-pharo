Class {
	#name : #APScriptMethodsCoder,
	#superclass : #GtMethodsCoder,
	#category : #'ActivePapers-Workflow'
}

{ #category : #'instance creation' }
APScriptMethodsCoder class >> forPaper: anAPActivePaper [
	^ self new
		forPaper: anAPActivePaper;
		yourself
]

{ #category : #initialization }
APScriptMethodsCoder >> forPaper: anAPActivePaper [
	| scripts |
	scripts := anAPActivePaper scripts values.
	scripts sort: [ :a :b | a selector <= b selector ].
	super forMethods: scripts
]

{ #category : #private }
APScriptMethodsCoder >> newMethodCoderFor: aMethod [
	| coder |
	coder := APScriptMethodCoder forMethod: aMethod.
	coder methodsCoder: self.
	coder expanded: false.
	^ coder
]
