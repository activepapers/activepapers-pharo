Extension { #name : #Timespan }

{ #category : #'*ActivePapersExamples' }
Timespan >> asTimespan [
	"Convert from the fixed-size subclasses of Timespan (Month, Week, Year)
	 to generic Timespans that can be used meaningfully in operations such
	 as + or intersection:."
	self class = Timespan
		ifTrue: [ ^ self ]
		ifFalse: [ ^ Timespan starting: self start duration: self duration ]
]
