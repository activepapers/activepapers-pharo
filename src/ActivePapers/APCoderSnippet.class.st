Class {
	#name : #APCoderSnippet,
	#superclass : #GtCoderSnippet,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #initialization }
APCoderSnippet >> initialize [
	super initialize.
	coder addOns
		"Remove the 'eg' button"
		removeMainAction: nil;
		"Add a button for conversion to a script"
		addMainAction: 'Script' translated
			icon: BrGlamorousIcons tohere
			action: [ :aButton | self replaceByScriptSnippet: aButton ].

]

{ #category : #initialization }
APCoderSnippet >> replaceByScriptSnippet: aButton [
	self requestSnippetReplacement: APScriptSnippet
		  initializedWith:
			[ :snippet |
				snippet updateForCodeSnippet: self text
						  inClass: coder variableBindings receiver class ].

]

{ #category : #accessing }
APCoderSnippet >> typeName [
	"Return a playground snippet type name.
	It should be an unique name among all playground snippet types."
	<return: #String>

	^ 'ActivePapers'
]
