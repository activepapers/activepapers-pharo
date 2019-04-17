Class {
	#name : #APScriptSnippet,
	#superclass : #GtExampleSnippet,
	#category : #'ActivePapers-ComputationalDocument'
}

{ #category : #updating }
APScriptSnippet >> updateForCodeSnippet: sourceCode inClass: aClass [
	| indentedLines methodSource |
	indentedLines := String streamContents: [ :stream | 
		sourceCode asString linesDo: [ :aLine |
			stream 
				nextPut: Character tab;
				nextPutAll: aLine;
				nextPut: Character lf ] ].
	methodSource := 'scriptName
	<computes: #datasetName>
', indentedLines.
	coder 
		forClass: aClass 
		source: methodSource
]
