Class {
	#name : #APDataPoint,
	#superclass : #Object,
	#traits : 'TAPData',
	#classTraits : 'TAPData classTrait',
	#instVars : [
		'#x => APDataSlot',
		'#y'
	],
	#category : #'ActivePapers-Tests'
}

{ #category : #initialization }
APDataPoint >> initialize [
	super initialize.
	self class initializeSlots: self.
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
