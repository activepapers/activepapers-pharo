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
