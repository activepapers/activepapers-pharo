Class {
	#name : #APIpfsMapperForDataFrames,
	#superclass : #IpfsDefaultMapper,
	#category : #ActivePapersExamples
}

{ #category : #initialization }
APIpfsMapperForDataFrames >> initialize [
	super initialize.
	self mappingForDataFrame.
]

{ #category : #mapping }
APIpfsMapperForDataFrames >> mappingForDataFrame [
	self encodeClass: DataFrame as:
		[ :df |
			| dataArray |
			dataArray := (1 to: df numberOfRows) collect:
				[ :i | (df at: i) asArray encodeForIpfsUsing: self ].
			NeoJSONObject with: #DataFrame ->
				(NeoJSONObject
					with: #data -> dataArray
					with: #columnNames -> (df columnNames encodeForIpfsUsing: self)
				 	with: #rowNames -> (df rowNames encodeForIpfsUsing: self)) ].
	self decodeTag: #DataFrame as:
		[ :jsonObject |
			| df |
			df := DataFrame new.
			df initializeRows: ((jsonObject at: #data) decodeFromIpfsUsing: self).
			df columnNames: ((jsonObject at: #columnNames) decodeFromIpfsUsing: self).
			df rowNames: ((jsonObject at: #rowNames) decodeFromIpfsUsing: self).
			df ].
]
