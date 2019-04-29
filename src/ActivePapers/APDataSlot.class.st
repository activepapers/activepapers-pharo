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
		pushTemp: tempName.
	super emitStore: aMethodBuilder
]

{ #category : #'code generation' }
APDataSlot >> emitValue: aMethodBuilder [
	aMethodBuilder
		pushReceiver;
		pushLiteralVariable: #slot -> self;
		send: #readAccessToSlot:.	
	super emitValue: aMethodBuilder.
]
