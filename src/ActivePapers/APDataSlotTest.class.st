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
APDataSlotTest >> testDoubleInitializationDoesNotEraseValues [
	point x: 5.
	point y: 2.
	point class initializeSlots: point.
	self assert: point x equals: 5.
	self assert: point y equals: 2.

]

{ #category : #tests }
APDataSlotTest >> testExplicitReadNotificationRaisesEventExactlyOnce [

	| count |
	count := 0.
	point property: #x whenReadDo: [ count := count + 1 ].

	point notifyPropertyRead: #x.

	self assert: count equals: 1.
]

{ #category : #tests }
APDataSlotTest >> testExplicitReadNotificationRaisesEventWithCurrentValue [

	| currentValue |
	point x: 17.
	point property: #x whenReadDo: [ :v | currentValue := v ].

	point notifyPropertyRead: #x.

	self assert: currentValue equals: 17.
]

{ #category : #tests }
APDataSlotTest >> testInstanceVariableAccessRaisesEventExactlyOnce [

	|  count |
	count := 0.
	point property: #x whenReadDo: [ count := count + 1 ].

	point x.

	self assert: count equals: 1.
]

{ #category : #tests }
APDataSlotTest >> testSubscribeToReadRaisesEventWithCurrentValue [

	| currentValue |
	point x: 17.

	point property: #x whenReadDo: [ :v | currentValue := v ].

	point x.

	self assert: currentValue equals: 17.
]

{ #category : #tests }
APDataSlotTest >> testSubscribeToReadUnexistentPropertyRaisesError [

	self
		should: [
			point
				property: #z
				whenReadDo: [ self fail: 'This event should''nt have been subscribed at all' ] ]
		raise: SlotNotFound
]
