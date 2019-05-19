Extension { #name : #GtMethodCoder }

{ #category : #'*ActivePapers' }
GtMethodCoder >> activePaperScriptAstFor: anAST [
	<gtAstCoderAddOns: 11>
	(self isActivePaperScript: anAST)
		ifFalse: [ ^ self ].
	addOns addContextAction: 'Play' translated
			 icon: BrGlamorousIcons play
			 action: [ :button | self playActivePaperScriptFrom: button ].
	addOns addContextAction: 'Play and Inspect' translated
			 icon: BrGlamorousIcons playinspect
			 action: [ :button | self playAndInspectActivePaperScriptFrom: button ].
	addOns addContextAction: 'Debug' translated
			 icon: BrGlamorousIcons debug
			 action: [ :button | self debugActivePaperScript ].
]

{ #category : #'*ActivePapers' }
GtMethodCoder >> debugActivePaperScript [
	| compiledMethod context process debuggingSession |
	self isModified
		ifTrue: [ self save
			ifFalse: [ ^ self ] ].
	compiledMethod := self classOrMetaClass methodNamed: self selector.
	context := [ compiledMethod valueWithReceiver: self classOrMetaClass uniqueInstance
										arguments: #() ] asContext.
	process := Process
		forContext: context
		priority: Processor userInterruptPriority.
	debuggingSession := (process 
		newDebugSessionNamed: 'Debug ', self selector
		startedAt: process suspendedContext).
	10 timesRepeat: [ 
		debuggingSession stepInto ].
	GtExpandableDebuggerElement openInspectorOn: debuggingSession.
]

{ #category : #'*ActivePapers' }
GtMethodCoder >> isActivePaperScript: anAST [
	| node |
	(self classOrMetaClass inheritsFrom: APActivePaper)
		ifFalse: [ ^ false ].
"	Transcript crLog: 'inherits from APActivePaper'.
"	anAST ifNil: [ ^ false ].
"	Transcript crLog: 'AST is non-nil'.
"	node := anAST methodNode.
	node ifNil: [ ^ false ].
"	Transcript crLog: 'AST method node is non-nil'.
"	node arguments ifNotEmpty: [ ^ false ].
"	Transcript crLog: 'method is unary'.
"	^ node pragmas anySatisfy: [ :each | each selector = #computes: ].
]

{ #category : #'*ActivePapers' }
GtMethodCoder >> playActivePaperScriptFrom: anElement [
	self isModified
		ifTrue: [ self save
				ifFalse: [ ^ self ] ].
	self classOrMetaClass uniqueInstance perform: self selector.
]

{ #category : #'*ActivePapers' }
GtMethodCoder >> playAndInspectActivePaperScriptFrom: anElement [
	| compiledMethod datasetNames datasets |
	self playActivePaperScriptFrom: anElement.
	compiledMethod := self classOrMetaClass methodNamed: self selector.
	datasetNames := compiledMethod pragmas
		select: [ :p | p selector = #computes: ]
		thenCollect: [ :p | p arguments first ].
	datasets := self classOrMetaClass datasets.
	datasetNames size = 1
		ifTrue: [ anElement phlow spawnObject:
						(datasets at: datasetNames first) ]
		ifFalse: [ anElement phlow spawnObject:
						(datasetNames collect:
								[ :each | each -> (datasets at: each)] ) asDictionary ]
]
