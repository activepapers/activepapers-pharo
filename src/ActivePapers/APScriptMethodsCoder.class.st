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
	super forMethods: anAPActivePaper scripts values
]

{ #category : #private }
APScriptMethodsCoder >> newMethodCoderFor: aMethod [
	| coder |
	coder := APScriptMethodCoder forMethod: aMethod.
	coder methodsCoder: self.
	coder expanded: true.
	^ coder
]
