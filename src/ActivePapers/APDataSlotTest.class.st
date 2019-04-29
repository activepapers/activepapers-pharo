Class {
	#name : #APDataSlotTest,
	#superclass : #ObservableSlotTest,
	#category : #'ActivePapers-Tests'
}

{ #category : #tests }
APDataSlotTest >> setUp [

	super setUp.
	point := APDataPoint new.
]

{ #category : #tests }
APDataSlotTest >> testAccessCounts [
	point x: 1.
	point x: 1.
	point y: 2.
	point y: 2.
	point x.
	point x.
	point x.
	point y.
	point y.
	point y.
	self assert: point readAccessCount equals: 3.
	self assert: point writeAccessCount equals: 2.

]
