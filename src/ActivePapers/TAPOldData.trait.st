"
!A trait that manages dataset slots in ActivePapers

This is an extension of ${class:name=TObservable}$ that adds two methods for tracking read access to the underlying ${class:name=APValueHolder|show=#gtDocumentFor:}$.

"
Trait {
	#name : #TAPOldData,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#category : #'ActivePapers-OldDataSlots'
}

{ #category : #events }
TAPOldData >> notifyPropertyRead: aName [

	(self observablePropertyNamed: aName) valueRead
]

{ #category : #events }
TAPOldData >> property: aName whenReadDo: aBlockClosure [ 
	
	"Obtain the raw value.
	We need to access the underlying value holder to subscribe to it"
	(self observablePropertyNamed: aName) whenReadDo: aBlockClosure
]
