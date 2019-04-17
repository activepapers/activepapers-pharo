Class {
	#name : #APCoderSnippet,
	#superclass : #GtCoderSnippet,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #initialization }
APCoderSnippet >> initialize [
	super initialize.
"	coder addOns
		addMainAction: 'Script' translated
		icon: BrGlamorousIcons playinspect
		action: [ :aButton | self doItAndGoSelectionOrAll: aButton ].
"
]
