"
!Annual influenza-like illness epidemics in France

Using the ${activePaper:name=InfluenzaLikeIllnessIncidenceInFrance}$ dataset, we identify the years with the strongest epidemics, and more generally look at the distribution of the number of annual victims.

${wikiPage:name=Verification}$

!!Definition of the annual incidences

The weekly incidences of influenza-like illness show a pronounced peak in late January or early February, and very low values in summer. Therefore we define the annual incidence as the sum over the weekly incidences for a one-year period starting with the week that contains the 1st of August of the preceding year:
${method:name=AnnualInfluenzaLikeIllnessEpidemicsInFrance>>#timespanForPeakOfYear:|expanded=}$
The following plot shows such a one-year summation period:
[[[
APGraphics show:
	(self dataset incidencePlotFor:
		(self weeklyIncidencesForYear: 2015))
]]]

We can compute the annual incidences for the years whose summation periods are completely contained in the dataset:
${method:name=AnnualInfluenzaLikeIllnessEpidemicsInFrance>>#defineYearRange|expanded=}$

!!The most important epidemics

The following table sorted by descreasing incidence shows three years with exceptionally high annual incidence values:
[[[
self annualIncidence sortDescendingBy: 'incidenceEstimation'
]]]

!!The distribution of the severity of epidemics


"
Class {
	#name : #AnnualInfluenzaLikeIllnessEpidemicsInFrance,
	#superclass : #APActivePaper,
	#instVars : [
		'#weeklyIncidence => APDataSlot',
		'#dataset => APDataSlot',
		'#yearRange => APDataSlot',
		'#annualIncidence => APDataSlot'
	],
	#category : #ActivePapersExamples
}

{ #category : #wikiPages }
AnnualInfluenzaLikeIllnessEpidemicsInFrance class >> wikiPageVerification [
	"This method was automatically generated."
	<wikiPage: #Verification>
	^APWikiPage
		wiki: self
		name: #Verification
		text: 
'!Verification

Check that a year starting at August 1st contains 52 or 53 weeks.
[[[
(1990 to: 2000) do:
	[ :year |
		| data |
		data := self weeklyIncidencesForYear: year.
		self assert: (#(52 53) includes:  data size) ]
]]]
'
]

{ #category : #generated }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> annualIncidence [ ^ annualIncidence
]

{ #category : #scripts }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> computeAnnualIncidence [
	<computes: #annualIncidence>
	annualIncidence :=
		DataFrame
			withColumns: { yearRange.
								yearRange collect:
								[ :year | ((self weeklyIncidencesForYear: year)
												column: 'estimation') sum ] }
			columnNames: #(year incidenceEstimation).
]

{ #category : #generated }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> dataset [ ^ dataset
]

{ #category : #scripts }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> defineYearRange [
	<computes: #yearRange>
	yearRange := self firstCompleteYear to: self lastCompleteYear.

]

{ #category : #selecting }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> firstCompleteYear [
	| firstWeek yearOfFirstWeek |
	firstWeek := (weeklyIncidence at: 1) at: 'week'.
	yearOfFirstWeek := firstWeek start year.
	(self firstDayForPeakOfYear: yearOfFirstWeek+1) < firstWeek start
		ifTrue: [ ^ yearOfFirstWeek + 2 ]
		ifFalse: [ ^ yearOfFirstWeek + 1].
]

{ #category : #accessing }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> firstDayForPeakOfYear: aYearNumber [
	^ DateAndTime year: aYearNumber-1 month: 8 day: 1
]

{ #category : #selecting }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> lastCompleteYear [
	| lastWeek yearOfLastWeek |
	lastWeek := (weeklyIncidence at: weeklyIncidence size) at: 'week'.
	yearOfLastWeek := lastWeek end year.
	(self firstDayForPeakOfYear: yearOfLastWeek+1) > lastWeek end
		ifTrue: [ ^ yearOfLastWeek - 1 ]
		ifFalse: [ ^ yearOfLastWeek ].
]

{ #category : #scripts }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> retrieveDataset [
	<computes: #dataset>
	dataset := InfluenzaLikeIllnessIncidenceInFrance data

]

{ #category : #scripts }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> retrieveWeeklyIncidence [
	<computes: #weeklyIncidence>
	weeklyIncidence := dataset absoluteIncidence

]

{ #category : #selecting }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> timespanForPeakOfYear: aYearNumber [
	^ Timespan
		starting: (self firstDayForPeakOfYear: aYearNumber)
		ending: (self firstDayForPeakOfYear: aYearNumber+1)
]

{ #category : #generated }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> weeklyIncidence [ ^ weeklyIncidence
]

{ #category : #selecting }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> weeklyIncidencesForYear: aYearNumber [
	^ dataset
		selectTimespan: (self timespanForPeakOfYear: aYearNumber)
		forIncidenceData: weeklyIncidence
]

{ #category : #generated }
AnnualInfluenzaLikeIllnessEpidemicsInFrance >> yearRange [ ^ yearRange
]
