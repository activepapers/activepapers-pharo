Class {
	#name : #APDataPoint,
	#superclass : #Object,
	#instVars : [
		'#x => APDataSlot',
		'#y',
		'#readAccessCount',
		'#writeAccessCount'
	],
	#category : #'ActivePapers-Tests'
}

{ #category : #initialization }
APDataPoint >> initialize [
	super initialize.
	readAccessCount := 0.
	writeAccessCount := 0.
]

{ #category : #accessing }
APDataPoint >> readAccessCount [
	^ readAccessCount
]

{ #category : #'slot access' }
APDataPoint >> readAccessToSlot: aSlot [
	self assert: aSlot name = #x.
	readAccessCount := readAccessCount + 1.
]

{ #category : #accessing }
APDataPoint >> writeAccessCount [
	^ writeAccessCount
]

{ #category : #'slot access' }
APDataPoint >> writeAccessToSlot: aSlot [
	self assert: aSlot name = #x.
	writeAccessCount := writeAccessCount + 1.
]

{ #category : #accessing }
APDataPoint >> x [
	^ x
]

{ #category : #accessing }
APDataPoint >> x: anInteger [ 
	x := anInteger
]

{ #category : #accessing }
APDataPoint >> y [
	^ y
]

{ #category : #accessing }
APDataPoint >> y: anInteger [ 
	y := anInteger
]
