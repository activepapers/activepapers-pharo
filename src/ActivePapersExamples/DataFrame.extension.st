Extension { #name : #DataFrame }

{ #category : #'*ActivePapersExamples' }
DataFrame >> gtTableFor: aView [
	<gtView>
	| aList |
	aList := aView columnedList
		title: 'Table' translated;
		priority: 10;
		items: [ self asArrayOfRows ].
	self columnNames
		do: [ :cn | 
			aList column
				title: cn;
				weight: 1;
				item: [ :each | each at: cn ] ].
	^ aList
]
