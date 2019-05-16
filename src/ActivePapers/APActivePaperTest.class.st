"
Tests for ${class:name=APActivePapers}$
"
Class {
	#name : #APActivePaperTest,
	#superclass : #TestCase,
	#instVars : [
		'activePaper',
		'activePaperInstance'
	],
	#category : #'ActivePapers-Tests'
}

{ #category : #running }
APActivePaperTest >> setUp [
	EpMonitor current disable.
	activePaper := APActivePaper subclass: #APActivePaperTestExample.
	activePaperInstance := activePaper uniqueInstance.
]

{ #category : #running }
APActivePaperTest >> tearDown [
	activePaperInstance := nil.
	activePaper removeFromSystem.
	EpMonitor current enable.
]

{ #category : #testing }
APActivePaperTest >> testDataDefinitionAndRetrieval [
	activePaper addInstVarNamed: 'x'.
	self assert: (activePaperInstance isValidDataset: #x) not.
	activePaper compile: 'setX <computes: #x> x := 42'.
	self assert: activePaperInstance x equals: 42.
	self assert: (activePaperInstance isValidDataset: #x).

]

{ #category : #testing }
APActivePaperTest >> testDependencyChain [
	activePaper addInstVarNamed: 'x y z'.
	self assert: (activePaperInstance isValidDataset: #x) not.
	self assert: (activePaperInstance isValidDataset: #y) not.
	self assert: (activePaperInstance isValidDataset: #z) not.
	activePaper compile: 'setX <computes: #x> x := 1'.
	activePaper compile: 'computeY <computes: #y> y := x + 1'.
	activePaper compile: 'computeZ <computes: #z> z := y + 1'.

	self assert: activePaperInstance x equals: 1.
	self assert: activePaperInstance y equals: 2.
	self assert: activePaperInstance z equals: 3.
	self assert: (activePaperInstance isValidDataset: #x).
	self assert: (activePaperInstance isValidDataset: #y).
	self assert: (activePaperInstance isValidDataset: #z).
	
	activePaperInstance invalidateDataset: #y.
	self assert: (activePaperInstance isValidDataset: #x).
	self deny: (activePaperInstance isValidDataset: #y).
	self deny: (activePaperInstance isValidDataset: #z).

]

{ #category : #testing }
APActivePaperTest >> testErrorComputingMethodRequiresArguments [
	activePaper addInstVarNamed: 'x'.
	activePaper compile: 'setX: anInteger <computes: #x> x := 42'.
	"The first computation should raise an error"
	self should: [ activePaperInstance x ] raise: Error.
]

{ #category : #testing }
APActivePaperTest >> testErrorTwoMethodsComputeSameVariable [
	activePaper addInstVarNamed: 'x'.
	activePaper compile: 'setX1 <computes: #x> x := 42'.
	activePaper compile: 'setX2 <computes: #x> x := 11'.
	"The first computation should raise an error"
	self should: [ activePaperInstance x ] raise: Error.
]

{ #category : #testing }
APActivePaperTest >> testErrorUncomputedInstVar [
	activePaper addInstVarNamed: 'x y'.
	activePaper compile: 'setX <computes: #x> x := 1'.
	self should: [ activePaperInstance x ] raise: Error.
]

{ #category : #testing }
APActivePaperTest >> testErrorUndeclaredComputedVar [
	activePaper addInstVarNamed: 'x'.
	activePaper compile: 'setX <computes: #x> x := 1'.
	activePaper compile: 'setY <computes: #y> x := 1'.
	self should: [ activePaperInstance x ] raise: Error.
]

{ #category : #testing }
APActivePaperTest >> testInstVarAndScriptCreation [
	activePaper addInstVarNamed: 'x'.
	self assert: activePaper workflowMethods isEmpty.
	self assert: (activePaper methods select: [ :each | each protocol = 'generated']) size equals: 1.
	"There is no method for computing x, so access to x is an error."
	self should: [ activePaperInstance x ] raise: Error.
	
	activePaper compile: 'setX <computes: #x> x := 42'.
	self assert: activePaper workflowMethods size equals: 1.
	self assert: (activePaper methods select: [ :each | each protocol = 'generated']) size equals: 1.

]
