"
!Code snippet in an ActivePapers playground

A modified version of ${class:name=GtCoderSnippet}$ for use by ${class:name=APPlayPage}$. Removes the ""eg"" button (which is not useful in this context) and adds a button for converting the snippet into a script represented by a ${class:name=APScriptSnippet}$.
"
Class {
	#name : #APCoderSnippet,
	#superclass : #GtCoderSnippet,
	#category : #'ActivePapers-Playground'
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
