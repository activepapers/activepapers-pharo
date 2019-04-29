Class {
	#name : #APDataSlot,
	#superclass : #InstanceVariableSlot,
	#category : #'ActivePapers-DataSlots'
}

{ #category : #'code generation' }
APDataSlot >> emitStore: aMethodBuilder [
	aMethodBuilder
		pushReceiver;
		pushLiteralVariable: #slot -> self;
		send: #writeAccessToSlot:.	
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
