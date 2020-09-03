"
!Incidence of influenza-like illness in France

This dataset on the incidence of influenza-like illness (French: syndrôme grippal) in France has been made available by the ""Réseau Sentinelles"" (*https://www.sentiweb.fr/*) and provides estimates extrapolated from the diagnoses made by general practitioners all over the country. The dataset contains cumulative weekly data, starting in October 1984. Unfortunately, the Web site does not provide the raw data (number of diagnoses), nor an explanation of the statistical methods used for generating the estimates.

For each week, an  incidence estimation is provided together with a 95% confidence interval. A population-relative incidence estimatation (cases per 100.000 inhabitants) is provided as well, again with a 95% confidence interval. The Web site does not say where the population data has been taken from.

See ${wikiPage:name=DataProcessing}$ for an explanation of how the datasets in this document were obtained from the downloaded tables, and ${wikiPage:name=Verification}$ for consistency and validity checks.

Here is a tabular view of the data:
[[[
self data.
]]]

And here are the descriptions of the fields provided by the Web site:
[[[
self fieldDescriptions
]]]


A plot of a three-year period shows the seasonal character of the incidence:
[[[
| threeYears |
threeYears := Timespan starting: (DateAndTime fromString: '2015-01-01') duration: 4 years.
APGraphics show:
	(self incidencePlotFor:
		(self selectTimespan: threeYears
				forIncidenceData: self absoluteIncidence))
]]]

"
Class {
	#name : #InfluenzaLikeIllnessIncidenceInFrance,
	#superclass : #APActivePaper,
	#instVars : [
		'#downloadUrl => APDataSlot',
		'#csvFile => APDataSlot',
		'#textData => APDataSlot',
		'#data => APDataSlot',
		'#fieldDescriptions => APDataSlot',
		'#absoluteIncidence => APDataSlot',
		'#populationRelativeIncidence => APDataSlot'
	],
	#category : #ActivePapersExamples
}

{ #category : #wikiPages }
InfluenzaLikeIllnessIncidenceInFrance class >> wikiPageDataProcessing [
	"This method was automatically generated."
	<wikiPage: #DataProcessing>
	^ '!Data processing steps

1. Set the URL for downloading the data
${method:name=InfluenzaLikeIllnessIncidenceInFrance>>#setDownloadUrl|expanded=}$

2. Download the CSV file into a string
${method:name=InfluenzaLikeIllnessIncidenceInFrance>>#downloadCsvFile|expanded=}$

3. Parse the CSV data into a ${class:name=DataFrame}$
${method:name=InfluenzaLikeIllnessIncidenceInFrance>>#parseCsvFile|expanded=}$

4. Download the descriptions of the individual fields (provided as a JSON schema)
${method:name=InfluenzaLikeIllnessIncidenceInFrance>>#downloadFieldDescriptions|expanded=}$
5. Convert each column to the appropriate data type. The data type is taken from the field descriptions. All columns are either ==''integer''== or ==''string''==. There is a special treatment for column ==''week''== which is listed as ==''integer''==, but the integer is really a special encoding of an ISO-8601 week number. For the standard ==''integer''== columns, illegal values are converted to ==nil==.
${method:name=InfluenzaLikeIllnessIncidenceInFrance>>#convertDataTypes|expanded=}$

6. Extract separate data frames for the absolute and the population-relative incidence estimations, removing missing data points. The resulting datasets are the most useful ones for analysis.
${method:name=InfluenzaLikeIllnessIncidenceInFrance>>#extractIncidenceData|expanded=}$



'
]

{ #category : #wikiPages }
InfluenzaLikeIllnessIncidenceInFrance class >> wikiPageVerification [
	"This method was automatically generated."
	<wikiPage: #Verification>
	^ '!Verification

!!Completeness

One week in the dataset has missing data:
[[[
missingData := self data select:
	[ :row | (row collect: #isNil) includes: true ].
self assert: missingData size = 1.
missingData
]]]

Searching for gaps (week-to-week distances of more than seven days) in the week column after removing the missing data point yields exactly one gap corresponding to the missing data point, meaning that the dataset is otherwise complete:
[[[
| weeks gaps |
weeks := (self absoluteIncidence column: ''week'') asArray.
gaps := OrderedCollection new.
weeks allButFirst with: weeks allButLast do:
	[ :w2 :w1 |
		(w2 - w1) = (Duration days: 7)
			ifFalse: [ gaps add: { w2-w1. w1 . w2 } ] ].
self assert: gaps size = 1.
self assert: ((missingData column: ''week'') first
					 - gaps first second) = (Duration days: 7).
gaps
]]]

!!Correctness

All incidence estimates and their confidence interval limits are positive:
[[[
{ self absoluteIncidence. self populationRelativeIncidence } do:
	[ :dataSet |
		dataSet columnNames allButFirst do:
		[ :columnName |
			self assert:
				((dataSet column: columnName)
					detect: [ :value | value < 0 ]
					ifNone: [ nil ]) isNil ] ]
]]]
'
]

{ #category : #generated }
InfluenzaLikeIllnessIncidenceInFrance >> absoluteIncidence [ ^ absoluteIncidence
]

{ #category : #'data conversion' }
InfluenzaLikeIllnessIncidenceInFrance >> convertColumnToNumbers: aColumn [
	^ aColumn collect:
		[ : each |
			[ each asNumber ]
			on: Error do: [ :exception | nil ] ]
]

{ #category : #scripts }
InfluenzaLikeIllnessIncidenceInFrance >> convertDataTypes [
	<computes: #data>
	| columnNames |

	"Make a new data frame of equal dimensions and column names."
	columnNames := textData columnNames.
	data := DataFrame new: textData dimensions.
	data columnNames: columnNames.
	columnNames := columnNames copy.

	"Transform week column into Week objects."
	data column: 'week'
		  put: ((textData column: 'week') collect:
					[ :each | Week year: (each first: 4) asNumber
										isoWeek: (each last: 2) asNumber ]).
	columnNames remove: 'week'.

	"Transform numerical columns into numbers, keep text columns as text"
	columnNames do:
		[ :cn |
			| column type |
			column := textData column: cn.
			type := (fieldDescriptions at: cn) at: 'type'.
			type = 'integer'
				ifTrue: [ column := self convertColumnToNumbers: column ].
			data column: cn put: column ].

	"Sort by ascending week number."
	data sortBy: 'week'.
	
	"Check that all data was converted."
	self assert: data dimensions = textData dimensions.
]

{ #category : #generated }
InfluenzaLikeIllnessIncidenceInFrance >> csvFile [ ^ csvFile
]

{ #category : #generated }
InfluenzaLikeIllnessIncidenceInFrance >> data [ ^ data
]

{ #category : #scripts }
InfluenzaLikeIllnessIncidenceInFrance >> downloadCsvFile [
	<computes: #csvFile>
	| dataFile |
	dataFile :=
		ZnClient new
			beOneShot;
			get: downloadUrl;
			entity.
	csvFile := dataFile contents
]

{ #category : #scripts }
InfluenzaLikeIllnessIncidenceInFrance >> downloadFieldDescriptions [
	<computes: #fieldDescriptions>
	| schemaUrl schemaJson schema |
	schemaUrl := 'https://ns.sentiweb.fr/incidence/csv-schema-v1.json'.
	schemaJson :=
			ZnClient new
				beOneShot;
				get: schemaUrl;
				entity.
	schema := STONJSON fromString: schemaJson contents.
	fieldDescriptions := Dictionary new.
	((schema at: 'schema') at: 'fields') do:
		[ :field |
			fieldDescriptions at: (field at: 'name') put: field ].

]

{ #category : #generated }
InfluenzaLikeIllnessIncidenceInFrance >> downloadUrl [ ^ downloadUrl
]

{ #category : #scripts }
InfluenzaLikeIllnessIncidenceInFrance >> extractIncidenceData [
	<computes: #absoluteIncidence>
	<computes: #populationRelativeIncidence>
	| validData |
	validData := data select:
						[ :row |
							(row detect: #isNil
								  ifFound: [ false ]
								  ifNone: [ true ]) ].
	absoluteIncidence := validData columns: #('week' 'inc' 'inc_low' 'inc_up').
	absoluteIncidence columnNames:
		#('week' 'estimation' 'confidenceInterval95LowerLimit' 'confidenceInterval95UpperLimit').
	populationRelativeIncidence := validData columns: #('week' 'inc100' 'inc100_low' 'inc100_up').
	populationRelativeIncidence columnNames:
		#('week' 'estimation' 'confidenceInterval95LowerLimit' 'confidenceInterval95UpperLimit')
]

{ #category : #generated }
InfluenzaLikeIllnessIncidenceInFrance >> fieldDescriptions [ ^ fieldDescriptions
]

{ #category : #plotting }
InfluenzaLikeIllnessIncidenceInFrance >> incidencePlotFor: incidenceDataSeries [
	| minDate b ds |
	minDate := (incidenceDataSeries column: 'week') first start asDate.
	b := RTGrapher new.
	b extent: 300 @ 200.
	ds := RTData new.
	ds label: 'Incidence of influenza-like illness'.
	ds interaction popup.
	ds points: (incidenceDataSeries columns: #('week' 'estimation')).
	ds x: [ :point | ((point at: 'week') start asDate julianDayNumber) - minDate julianDayNumber ].
	ds y: [ :point | point at: 'estimation' ].
	ds barShape color: Color blue; width: 1.
	ds noDot.
	b add: ds.

	b axisX
		labelRotation: -40;
		labelConversion: [ :v | Date julianDayNumber: v + minDate julianDayNumber ].
	b axisY.

	b addDecorator:
		(RTCursorFollower new
			labelXTextConvertion: [ :v | Date julianDayNumber: v + minDate julianDayNumber ]).

	b build.
	b view @ RTZoomableView @ RTZoomableBoxView.
	^ b
]

{ #category : #initialization }
InfluenzaLikeIllnessIncidenceInFrance >> initialize [
	super initialize.
	self class initializeSlots: self.
]

{ #category : #scripts }
InfluenzaLikeIllnessIncidenceInFrance >> parseCsvFile [
	<computes: #textData>
	| csvLines dataLines |
	csvLines := csvFile lines.
	dataLines := csvLines allButFirst: 2.
	textData := DataFrame withRows:
		(dataLines collect: [ :each | each splitOn: ',' ]).
	textData columnNames:
		((csvLines at: 2) splitOn: ',')

]

{ #category : #generated }
InfluenzaLikeIllnessIncidenceInFrance >> populationRelativeIncidence [ ^ populationRelativeIncidence
]

{ #category : #selecting }
InfluenzaLikeIllnessIncidenceInFrance >> selectTimespan: aTimespan forIncidenceData: anIncidenceDataFrame [
	"Select all weeks whose intersection with the given timespan is more than half a week."
	aTimespan ifNil: [ ^ anIncidenceDataFrame ].
	^ anIncidenceDataFrame select:
		[ :row | ((row at: 'week') asTimespan
						intersection: aTimespan)
						ifNil: [ false ]
						ifNotNil: [ :ts | ts duration * 2 > 1 week ] ]
]

{ #category : #scripts }
InfluenzaLikeIllnessIncidenceInFrance >> setDownloadUrl [
	<computes: #downloadUrl>
	downloadUrl := 'http://www.sentiweb.fr/datasets/incidence-PAY-3.csv'
]

{ #category : #generated }
InfluenzaLikeIllnessIncidenceInFrance >> textData [ ^ textData
]
