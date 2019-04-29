"
!A slot for datasets in ActivePapers

This is a minor modification of ${class:name=ObservableSlot}$ that uses an ${class:name=APValueHolder|show=#gtDocumentFor:}$ instead of a ${class:name=NewValueHolder}$.

"
Class {
	#name : #APOldDataSlot,
	#superclass : #ObservableSlot,
	#category : #'ActivePapers-OldDataSlots'
}

{ #category : #'code generation' }
APOldDataSlot >> emitStore: aMethodBuilder [
	super emitStore: aMethodBuilder.
	"Push the value holder to the stack, then send unary message"
	aMethodBuilder pushInstVar: index.
	aMethodBuilder send: #validate.
]

{ #category : #initialization }
APOldDataSlot >> initialize: anObject [

	(self rawRead: anObject)
		ifNil: [self rawWrite: (APValueHolder new name: name) to: anObject]

]
