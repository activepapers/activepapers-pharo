"
Coder for a single script inside an ${class:name=APScriptMethodsCoder}$
"
Class {
	#name : #APScriptMethodCoder,
	#superclass : #GtMethodCoder,
	#category : #'ActivePapers-Computational Document'
}

{ #category : #executing }
APScriptMethodCoder >> debugScript [
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
		newDebugSessionNamed: 'test debugging'
		startedAt: process suspendedContext).
	10 timesRepeat: [ 
		debuggingSession stepInto ].
	GtExpandableDebuggerElement openInspectorOn: debuggingSession.
]

{ #category : #'initialize-release' }
APScriptMethodCoder >> initializeAddOns [
	super initializeAddOns.
	addOns addMainAction: 'Play' translated 
		icon: BrGlamorousIcons play
		action: [ :button | self playScript ].
	addOns addMainAction: 'Play and Inspect' translated 
		icon: BrGlamorousIcons playinspect 
		action: [ :button | self playAndInspectScriptFrom: button ].
	addOns addMainAction: 'Debug' translated 
		icon: BrGlamorousIcons debug
		action: [ :button | self debugScript ].
]

{ #category : #executing }
APScriptMethodCoder >> playAndInspectScriptFrom: anElement [
	| compiledMethod datasetNames datasets |
	self playScript.
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

{ #category : #executing }
APScriptMethodCoder >> playScript [
	self isModified
		ifTrue: [ self save
				ifFalse: [ ^ self ] ].
	self classOrMetaClass uniqueInstance perform: self selector.
]
