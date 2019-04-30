"
!A slot for datasets in ActivePapers

This is a modification of ${class:name=InstanceVariableSlot}$ that extends the methods ${method:name=APDataSlot>>#emitStore:}$ and ${method:name=APDataSlot>>#emitValue:}$ in such a way that announcement messages (==#readAccessToSlot:== and ==#writeAccessToSlot:==) are sent to the affected object before every read or write access.

"
Class {
	#name : #APDataSlot,
	#superclass : #InstanceVariableSlot,
	#category : #'ActivePapers-DataSlots'
}

{ #category : #'code generation' }
APDataSlot >> emitStore: aMethodBuilder [
	| tempName |
	tempName := Object new.
	aMethodBuilder
		addTemp: tempName;
		storeTemp: tempName;
		popTop;
		pushReceiver;
		pushLiteralVariable: #slot -> self;
		send: #writeAccessToSlot:;
		popTop;
		pushTemp: tempName.
	super emitStore: aMethodBuilder
]

{ #category : #'code generation' }
APDataSlot >> emitValue: aMethodBuilder [
	aMethodBuilder
		pushReceiver;
		pushLiteralVariable: #slot -> self;
		send: #readAccessToSlot:;
		popTop.
	super emitValue: aMethodBuilder.
]
