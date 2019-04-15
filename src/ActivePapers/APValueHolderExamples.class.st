"
!Examples for the use of APValueHolder

A new instance holds no information at all:
${method:name=APValueHolderExamples>>#emptyValueHolder|expanded=}$

An optional name can be defined:
${method:name=APValueHolderExamples>>#emptyNamedValueHolder|expanded=}$

The value can be set:
${method:name=APValueHolderExamples>>#valueHolderWithValue|expanded=}$

The value can also be invalidated:
${method:name=APValueHolderExamples>>#invalidatedValueHolderWithValue|expanded=}$

Read and write accesses can be tracked:
${method:name=APValueHolderExamples>>#valueHolderWithReadAnnouncements|expanded=}$
${method:name=APValueHolderExamples>>#valueHolderWithChangeAnnouncements|expanded=}$

"
Class {
	#name : #APValueHolderExamples,
	#superclass : #Object,
	#category : #'ActivePapers-Examples'
}

{ #category : #examples }
APValueHolderExamples >> emptyNamedValueHolder [
	| valueHolder |
	<gtExample>
	valueHolder := self emptyValueHolder.
	valueHolder name: self valueHolderName.
	self assert: valueHolder isValid not.
	self assert: valueHolder name equals: self valueHolderName.
	self assert: valueHolder timeStamp isNil.
	^ valueHolder

]

{ #category : #examples }
APValueHolderExamples >> emptyValueHolder [
	| valueHolder |
	<gtExample>
	valueHolder := APValueHolder new.
	self assert: valueHolder isValid not.
	self assert: valueHolder name isNil.
	self assert: valueHolder timeStamp isNil.
	^ valueHolder

]

{ #category : #examples }
APValueHolderExamples >> invalidatedValueHolderWithValue [
	| valueHolder |
	<gtExample>
	valueHolder := self valueHolderWithValue.
	valueHolder invalidate.
	self assert: valueHolder isValid not.
	^ valueHolder

]

{ #category : #examples }
APValueHolderExamples >> valueHolderName [
	^ 'aValueHolder'

]

{ #category : #examples }
APValueHolderExamples >> valueHolderNewValue [
	^ 'aString'
]

{ #category : #examples }
APValueHolderExamples >> valueHolderValue [
	^ 42
]

{ #category : #examples }
APValueHolderExamples >> valueHolderWithChangeAnnouncements [
	| valueHolder fired newValue oldValue announcement |
	<gtExample>
	valueHolder := self valueHolderWithValue.
	valueHolder whenChangedDo: [ fired := true ].

	"Setting a new value causes a change announcement"
	fired := false.
	self assert: self valueHolderValue ~= self valueHolderNewValue.
	valueHolder value: self valueHolderNewValue.
	self assert: fired.
	self assert: valueHolder value equals: self valueHolderNewValue.

	"More detailed information can be obtained using a block with parameters"
	valueHolder value: self valueHolderValue.
	valueHolder
		whenChangedDo:
			[ :new :old :ann |
				newValue := new.
				oldValue := old.
				announcement := ann ].
	fired := false.
	valueHolder value: self valueHolderNewValue.
	self assert: fired.
	self assert: oldValue = self valueHolderValue.
	self assert: newValue = self valueHolderNewValue.
	self assert: (announcement isKindOf: ValueChanged).
	self assert: oldValue = announcement oldValue.
	self assert: newValue = announcement newValue.

	"Setting the same value again also causes a change announcement"
	fired := false.
	valueHolder value: self valueHolderNewValue.
	self assert: fired.
	self assert: valueHolder value equals: self valueHolderNewValue.

	^ valueHolder

]

{ #category : #examples }
APValueHolderExamples >> valueHolderWithReadAnnouncements [
	| valueHolder fired heldValue sentAnnouncement |
	<gtExample>
	valueHolder := self valueHolderWithValue.

	"Read access can be tracked"
	fired := false.
	valueHolder whenReadDo: [ fired := true ].
	self assert: valueHolder value = self valueHolderValue.
	self assert: fired.

	"More detailed tracking is possible as well. Note that the first
	 block setting fired remains active when a second block is added."
	valueHolder whenReadDo:
		[ :value :announcement |
		 	heldValue := value.
			sentAnnouncement := announcement ].
	fired := false.
	self assert: valueHolder value equals: self valueHolderValue.
	self assert: fired.
	self assert: heldValue equals: self valueHolderValue.
	self assert: (sentAnnouncement isKindOf: APValueRead).
	self assert: heldValue = sentAnnouncement value.
	
	^ valueHolder

]

{ #category : #examples }
APValueHolderExamples >> valueHolderWithValue [
	| valueHolder |
	<gtExample>
	valueHolder := self emptyNamedValueHolder.
	valueHolder value: self valueHolderValue.
	self assert: valueHolder isValid.
	self assert: valueHolder value equals: self valueHolderValue.
	self assert: (valueHolder timeStamp isKindOf: DateAndTime).
	self assert: valueHolder timeStamp <= DateAndTime now.
	^ valueHolder

]
