Class {
	#name : #APDataPoint,
	#superclass : #Object,
	#traits : 'TAPOldData',
	#classTraits : 'TAPOldData classTrait',
	#instVars : [
		'#x => APOldDataSlot',
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
