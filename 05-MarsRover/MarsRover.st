!classDefinition: #InvalidCommand category: 'MarsRover'!
Error subclass: #InvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!InvalidCommand methodsFor: 'exceptionDescription' stamp: 'IB 5/15/2023 09:59:41'!
messageText

	^'An invalid command was found'! !


!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:43'!
testCanMoveBackwardsForwardsWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandToMoveBackwards , self commandToMoveForwards.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 11:00:13'!
testCanMoveBackwardsOneTimeWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandToMoveBackwards.
	
	self assertMarsRover: marsRover isPlacedAt: 0@-1 andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:23'!
testCanMoveBackwardsOneTimeWhenFacingSouth

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover executeAllCommandsIn: self commandToMoveBackwards.
	
	self assertMarsRover: marsRover isPlacedAt: 0@1 andFacing: South new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 11:00:08'!
testCanMoveBackwardsThreeTimesWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandsToMoveBackwardsThreeTimes.
	
	self assertMarsRover: marsRover isPlacedAt: 0@-3 andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:11'!
testCanMoveBackwardsThreeTimesWhenFacingSouth

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover executeAllCommandsIn: self commandsToMoveBackwardsThreeTimes.
	
	self assertMarsRover: marsRover isPlacedAt: 0@3 andFacing: South new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 11:00:04'!
testCanMoveBackwardsTwoTimesWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandsToMoveBackwardsTwoTimes.
	
	self assertMarsRover: marsRover isPlacedAt: 0@-2 andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:16'!
testCanMoveBackwardsTwoTimesWhenFacingSouth

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover executeAllCommandsIn: self commandsToMoveBackwardsTwoTimes.
	
	self assertMarsRover: marsRover isPlacedAt: 0@2 andFacing: South new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:01'!
testCanMoveBackwardsWhenFacingEast

	| marsRover |
	
	marsRover := self marsRoverFacingEast.
	
	marsRover executeAllCommandsIn: self commandToMoveBackwards.
	
	self assertMarsRover: marsRover isPlacedAt: -1@0 andFacing: East new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:58:48'!
testCanMoveBackwardsWhenFacingWest

	| marsRover |
	
	marsRover := self marsRoverFacingWest.
	
	marsRover executeAllCommandsIn: self commandToMoveBackwards.
	
	self assertMarsRover: marsRover isPlacedAt: 1@0 andFacing: West new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:58:41'!
testCanMoveForwardOneTimeWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandToMoveForwards.
	
	self assertMarsRover: marsRover isPlacedAt: 0@1 andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:38'!
testCanMoveForwardOneTimeWhenFacingSouth

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover executeAllCommandsIn: self commandToMoveForwards.
	
	self assertMarsRover: marsRover isPlacedAt: 0@-1 andFacing: South new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 11:00:00'!
testCanMoveForwardThreeTimesWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandsToMoveForwardThreeTimes.
	
	self assertMarsRover: marsRover isPlacedAt: 0@3 andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:27'!
testCanMoveForwardThreeTimesWhenFacingSouth

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover executeAllCommandsIn: self commandsToMoveForwardThreeTimes.
	
	self assertMarsRover: marsRover isPlacedAt: 0@-3 andFacing: South new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:54'!
testCanMoveForwardTwoTimesWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandsToMoveForwardTwoTimes.
	
	self assertMarsRover: marsRover isPlacedAt: 0@2 andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:32'!
testCanMoveForwardTwoTimesWhenFacingSouth

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover executeAllCommandsIn: self commandsToMoveForwardTwoTimes.
	
	self assertMarsRover: marsRover isPlacedAt: 0@-2 andFacing: South new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:47'!
testCanMoveForwardsBackwardsWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandToMoveForwards , self commandToMoveBackwards.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:59:06'!
testCanMoveForwardsWhenFacingEast

	| marsRover |
	
	marsRover := self marsRoverFacingEast.
	
	marsRover executeAllCommandsIn: self commandToMoveForwards.
	
	self assertMarsRover: marsRover isPlacedAt: 1@0 andFacing: East new! !

!MarsRoverTest methodsFor: 'tests - movement' stamp: 'IB 5/15/2023 10:58:53'!
testCanMoveForwardsWhenFacingWest

	| marsRover |
	
	marsRover := self marsRoverFacingWest.
	
	marsRover executeAllCommandsIn: self commandToMoveForwards.
	
	self assertMarsRover: marsRover isPlacedAt: -1@0 andFacing: West new! !


!MarsRoverTest methodsFor: 'support - asserting' stamp: 'IB 5/15/2023 10:22:15'!
assertMarsRover: aMarsRover isPlacedAt: aPosition andFacing: aCardinalDirection
	
	self assert: aMarsRover currentPosition equals: aPosition.
	self assert: aMarsRover cardinalDirection equals: aCardinalDirection! !

!MarsRoverTest methodsFor: 'support - asserting' stamp: 'IB 5/15/2023 10:34:27'!
executingAllCommandsIn: aCommandList in: aMarsRover shouldFailAndLeaveMarsRoverPlacedAt: aPosition facing: aCardinalDirection
	
	self should: [aMarsRover executeAllCommandsIn: aCommandList] 
		raise: InvalidCommand
		withExceptionDo: [:signal | self assert: signal messageText equals: 'An invalid command was found'.
			self assertMarsRover: aMarsRover isPlacedAt: aPosition andFacing: aCardinalDirection]! !


!MarsRoverTest methodsFor: 'support - commands' stamp: 'IB 5/15/2023 10:48:00'!
commandToMoveBackwards

	^ 'b'! !

!MarsRoverTest methodsFor: 'support - commands' stamp: 'IB 5/15/2023 10:48:13'!
commandToMoveForwards

	^ 'f'! !

!MarsRoverTest methodsFor: 'support - commands' stamp: 'IB 5/15/2023 10:47:44'!
commandToRotateLeft

	^ 'l'! !

!MarsRoverTest methodsFor: 'support - commands' stamp: 'IB 5/15/2023 10:47:03'!
commandToRotateRight

	^ 'r'! !

!MarsRoverTest methodsFor: 'support - commands' stamp: 'IB 5/15/2023 10:48:32'!
commandsToMoveBackwardsThreeTimes

	^ self commandsToMoveBackwardsTwoTimes , self commandToMoveBackwards! !

!MarsRoverTest methodsFor: 'support - commands' stamp: 'IB 5/15/2023 10:48:32'!
commandsToMoveBackwardsTwoTimes

	^ self commandToMoveBackwards , self commandToMoveBackwards! !

!MarsRoverTest methodsFor: 'support - commands' stamp: 'IB 5/15/2023 10:48:50'!
commandsToMoveForwardThreeTimes

	^ self commandsToMoveForwardTwoTimes , self commandToMoveForwards! !

!MarsRoverTest methodsFor: 'support - commands' stamp: 'IB 5/15/2023 10:48:50'!
commandsToMoveForwardTwoTimes

	^ self commandToMoveForwards , self commandToMoveForwards! !


!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'IB 5/15/2023 11:00:53'!
testCanRotateLeftWhenFacingEast

	| marsRover |
	
	marsRover := self marsRoverFacingEast.
	
	marsRover executeAllCommandsIn: self commandToRotateLeft.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: North new! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'IB 5/15/2023 11:00:22'!
testCanRotateLeftWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandToRotateLeft.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: West new! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'IB 5/15/2023 11:00:59'!
testCanRotateLeftWhenFacingSouth

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover executeAllCommandsIn: self commandToRotateLeft.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: East new! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'IB 5/15/2023 11:00:26'!
testCanRotateLeftWhenFacingWest

	| marsRover |
	
	marsRover := self marsRoverFacingWest.
	
	marsRover executeAllCommandsIn: self commandToRotateLeft.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: South new! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'IB 5/15/2023 11:00:49'!
testCanRotateRightWhenFacingEast

	| marsRover |
	
	marsRover := self marsRoverFacingEast.
	
	marsRover executeAllCommandsIn: self commandToRotateRight.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: South new! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'IB 5/15/2023 11:00:31'!
testCanRotateRightWhenFacingNorth

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: self commandToRotateRight.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: East new! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'IB 5/15/2023 11:00:37'!
testCanRotateRightWhenFacingSouth

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover executeAllCommandsIn: self commandToRotateRight.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: West new! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'IB 5/15/2023 11:00:42'!
testCanRotateRightWhenFacingWest

	| marsRover |
	
	marsRover := self marsRoverFacingWest.
	
	marsRover executeAllCommandsIn: self commandToRotateRight.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: North new! !


!MarsRoverTest methodsFor: 'tests' stamp: 'IB 5/15/2023 11:01:07'!
testEmptyCommandListDoesntMoveRover

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover executeAllCommandsIn: ''.
	
	self assertMarsRover: marsRover isPlacedAt: self marsRoverInitialPosition andFacing: North new! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IB 5/15/2023 11:01:21'!
testRaiseErrorAndDoesNotMoveWhenInvalidCommandReceived

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	self executingAllCommandsIn: 'x' 
		in: marsRover 
		shouldFailAndLeaveMarsRoverPlacedAt: self marsRoverInitialPosition 
		facing: North new! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IB 5/15/2023 11:01:16'!
testRaiseErrorAndDoesNotMoveWhenInvalidCommandReceivedAfterAValidOne

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	self executingAllCommandsIn: 'fx' 
		in: marsRover 
		shouldFailAndLeaveMarsRoverPlacedAt: 0@1 
		facing: North new! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IB 5/15/2023 11:01:12'!
testRaiseErrorAndDoesNotMoveWhenInvalidCommandReceivedFollowedByValidOnes

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	self executingAllCommandsIn: 'xf' 
		in: marsRover 
		shouldFailAndLeaveMarsRoverPlacedAt: self marsRoverInitialPosition 
		facing: North new! !


!MarsRoverTest methodsFor: 'support - mars rover' stamp: 'IB 5/15/2023 10:37:23'!
marsRoverFacingEast

	^ MarsRover placedAt: self marsRoverInitialPosition facingAt: East new! !

!MarsRoverTest methodsFor: 'support - mars rover' stamp: 'IB 5/15/2023 10:19:51'!
marsRoverFacingNorth

	^ MarsRover placedAt: self marsRoverInitialPosition facingAt: North new! !

!MarsRoverTest methodsFor: 'support - mars rover' stamp: 'IB 5/15/2023 10:37:06'!
marsRoverFacingSouth

	^ MarsRover placedAt: self marsRoverInitialPosition facingAt: South new! !

!MarsRoverTest methodsFor: 'support - mars rover' stamp: 'IB 5/15/2023 10:36:48'!
marsRoverFacingWest

	^ MarsRover placedAt: self marsRoverInitialPosition facingAt: West new! !

!MarsRoverTest methodsFor: 'support - mars rover' stamp: 'IB 5/15/2023 10:19:51'!
marsRoverInitialPosition

	^ 0@0! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:22:15'!
directionToMoveBackwards

	^ self directionToMoveForward negated! !

!CardinalPoint methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:18:47'!
directionToMoveForward

	self subclassResponsibility! !

!CardinalPoint methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:31:07'!
nextCardinalPoint

	self subclassResponsibility! !

!CardinalPoint methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:34:24'!
previousCardinalPoint

	^self nextCardinalPoint nextCardinalPoint nextCardinalPoint! !


!CardinalPoint methodsFor: 'comparing' stamp: 'IB 5/15/2023 09:43:10'!
= anObject

	^anObject isKindOf: self class

	! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:19:12'!
directionToMoveForward

	^ 1@0! !

!East methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:32:23'!
nextCardinalPoint

	^ South new! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:19:38'!
directionToMoveForward

	^ 0@1! !

!North methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:32:33'!
nextCardinalPoint

	^ East new! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:19:52'!
directionToMoveForward

	^ 0@-1! !

!South methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:32:47'!
nextCardinalPoint

	^ West new! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:20:14'!
directionToMoveForward

	^ -1@0! !

!West methodsFor: 'accessing' stamp: 'IB 5/15/2023 09:32:59'!
nextCardinalPoint

	^ North new! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position proceduresByCommand cardinalDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'IB 5/15/2023 09:53:10'!
initializePlacedAt: aPosition facingAt: aDirection

	position := aPosition.
	cardinalDirection := aDirection.
	
	self initializeProceduresByCommand! !

!MarsRover methodsFor: 'initialization' stamp: 'IB 5/15/2023 09:50:08'!
initializeProceduresByCommand

	^ proceduresByCommand := Dictionary new 
		at: $f put: [self moveForward]; 
		at: $b put: [self moveBackwards]; 
		at: $r put: [self rotateRight]; 
		at: $l put: [self rotateLeft]; 
		yourself! !


!MarsRover methodsFor: 'execution' stamp: 'IB 5/15/2023 11:04:56'!
executeAllCommandsIn: aCommandList

	aCommandList isEmpty ifTrue: [^self].
	
	aCommandList do: [:command | 
		proceduresByCommand at: command 
			ifPresent: [:procedure | procedure value] 
			ifAbsent: [InvalidCommand signal]]
! !


!MarsRover methodsFor: 'movement - private' stamp: 'IB 5/15/2023 09:50:48'!
moveTowards: aDirectionOfMovement
				
	position := position + aDirectionOfMovement! !

!MarsRover methodsFor: 'movement - private' stamp: 'IB 5/15/2023 10:15:18'!
rotateTo: aCardinalDirection

	cardinalDirection := aCardinalDirection ! !


!MarsRover methodsFor: 'movement' stamp: 'IB 5/15/2023 10:16:05'!
moveBackwards

	self moveTowards: cardinalDirection directionToMoveBackwards! !

!MarsRover methodsFor: 'movement' stamp: 'IB 5/15/2023 10:16:01'!
moveForward

	self moveTowards: cardinalDirection directionToMoveForward! !

!MarsRover methodsFor: 'movement' stamp: 'IB 5/15/2023 10:15:37'!
rotateLeft

	self rotateTo: cardinalDirection previousCardinalPoint ! !

!MarsRover methodsFor: 'movement' stamp: 'IB 5/15/2023 10:15:30'!
rotateRight

	self rotateTo: cardinalDirection nextCardinalPoint
! !


!MarsRover methodsFor: 'accesing' stamp: 'IB 5/15/2023 09:52:40'!
cardinalDirection

	^cardinalDirection! !

!MarsRover methodsFor: 'accesing' stamp: 'IB 5/15/2023 09:44:00'!
currentPosition

 	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'SG 5/14/2023 18:00:02'!
placedAt: aPosition facingAt: aDirection 

	^self new initializePlacedAt: aPosition facingAt: aDirection ! !
