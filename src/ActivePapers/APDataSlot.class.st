"
!A slot for datasets in ActivePapers

This is a minor modification of ${class:name=ObservableSlot}$ that uses an ${class:name=APValueHolder|show=#gtDocumentFor:}$ instead of a ${class:name=NewValueHolder}$.

"
Class {
	#name : #APDataSlot,
	#superclass : #ObservableSlot,
	#category : #'ActivePapers-DataSlots'
}

{ #category : #initialization }
APDataSlot >> initialize: anObject [

	(self rawRead: anObject)
		ifNil: [self rawWrite: (APValueHolder new name: name) to: anObject]

]
