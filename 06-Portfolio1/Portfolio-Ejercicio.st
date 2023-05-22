!classDefinition: #CompositeAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #CompositeAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!CompositeAccountTest methodsFor: 'assertions' stamp: 'IB 5/22/2023 01:36:56'!
assert: aCompositeAccount hasTheSameTransactionsAs: aCollectionOfAccounts
	
	|transactions|
	
	transactions := (aCollectionOfAccounts collect: #transactions) flatten.
	
	self assert: aCompositeAccount transactions size equals: transactions size.
	aCompositeAccount transactions do: [:transaction | self assert: transactions includes: transaction]! !

!CompositeAccountTest methodsFor: 'assertions' stamp: 'IB 5/21/2023 21:04:05'!
assertBalanceOf: aCompositeAccount equalsTo: aBalance

	self assert: aCompositeAccount balance equals: aBalance! !

!CompositeAccountTest methodsFor: 'assertions' stamp: 'IB 5/22/2023 00:18:48'!
shouldFailBecauseOfAssociationsWhenCreatingCompositeAccountWith: aBlockThatCreatesACompositeAccount

	^ self should: aBlockThatCreatesACompositeAccount
		raise: Error - MessageNotUnderstood 
		withMessageText: CompositeAccount sameAccountAssociatedMoreThanOnceErrorExplanation! !


!CompositeAccountTest methodsFor: 'support' stamp: 'IB 5/21/2023 21:47:30'!
anotherSimpleAccountWithTransactions
	
	^self emptySimpleAccount
		register: (Withdrawal for: 50);
		yourself! !

!CompositeAccountTest methodsFor: 'support' stamp: 'IB 5/22/2023 01:13:01'!
compositeAccount
	
	^self compositeAccountAssociatedWithAllIn: 
		{self simpleAccountWithTransactions. self anotherSimpleAccountWithTransactions }! !

!CompositeAccountTest methodsFor: 'support' stamp: 'IB 5/21/2023 21:07:51'!
compositeAccountAssociatedWithAllIn: aCollectionOfSimpleAccounts

	^ CompositeAccount associatedWithAllIn: aCollectionOfSimpleAccounts! !

!CompositeAccountTest methodsFor: 'support' stamp: 'IB 5/21/2023 21:29:27'!
emptySimpleAccount

	^ SimpleAccount new! !

!CompositeAccountTest methodsFor: 'support' stamp: 'IB 5/21/2023 21:31:29'!
simpleAccountWithTransactions

	^self emptySimpleAccount
		register: (Deposit for: 100);
		yourself! !


!CompositeAccountTest methodsFor: 'tests - balance' stamp: 'IB 5/22/2023 01:17:34'!
testBalanceWhenMoreThanOneAccountAssociated

	| anotherSimpleAccount simpleAccount compositeAccount | 
	
	simpleAccount := self simpleAccountWithTransactions.
	anotherSimpleAccount := self anotherSimpleAccountWithTransactions.
	
	compositeAccount := self compositeAccountAssociatedWithAllIn: {simpleAccount. anotherSimpleAccount}.
	
	self assertBalanceOf: compositeAccount equalsTo: simpleAccount balance + anotherSimpleAccount balance! !

!CompositeAccountTest methodsFor: 'tests - balance' stamp: 'IB 5/22/2023 01:16:33'!
testBalanceWhenOnlyOneAssociatedAccount

	| simpleAccount compositeAccount | 
	
	simpleAccount := self simpleAccountWithTransactions.
	
	compositeAccount := self compositeAccountAssociatedWithAllIn: {simpleAccount}.
	
	self assertBalanceOf: compositeAccount equalsTo: simpleAccount balance! !


!CompositeAccountTest methodsFor: 'tests - transactions' stamp: 'IB 5/22/2023 01:19:44'!
testCompositeAccountDoNotKnowsTransactionThatIsNotRegisteredOnItsOnlyAssociatedAccount

	| compositeAccount | 
	
	compositeAccount := self compositeAccountAssociatedWithAllIn: {self simpleAccountWithTransactions}.
	
	self deny: (compositeAccount hasRegistered: (Withdrawal for: 50))! !

!CompositeAccountTest methodsFor: 'tests - transactions' stamp: 'IB 5/21/2023 22:12:03'!
testCompositeAccountKnowsTransactionRegisteredOnItsOnlyAssociatedAccount

	| simpleAccount compositeAccount | 
	
	simpleAccount := self simpleAccountWithTransactions.
	compositeAccount := self compositeAccountAssociatedWithAllIn: {simpleAccount}.
	
	self assert: (compositeAccount hasRegistered: simpleAccount transactions first)! !

!CompositeAccountTest methodsFor: 'tests - transactions' stamp: 'IB 5/21/2023 22:16:43'!
testCompositeAccountKnowsTransactionsRegisteredOnItsAssociatedAccounts

	| simpleAccount anotherSimpleAccount compositeAccount | 
	
	simpleAccount := self simpleAccountWithTransactions.
	anotherSimpleAccount := self anotherSimpleAccountWithTransactions.
	compositeAccount := self compositeAccountAssociatedWithAllIn: {simpleAccount. anotherSimpleAccount}.
	
	self assert: (compositeAccount hasRegistered: simpleAccount transactions first).
	self assert: (compositeAccount hasRegistered: anotherSimpleAccount transactions first)! !

!CompositeAccountTest methodsFor: 'tests - transactions' stamp: 'IB 5/22/2023 01:32:48'!
testCompositeAccountTrasactionsAreEqualToTheOnesPresentInTheSimpleAccountsAssociatedToIt

	| compositeAccount associatedAccounts | 
	
	associatedAccounts := {self simpleAccountWithTransactions. self anotherSimpleAccountWithTransactions}.
	compositeAccount := self compositeAccountAssociatedWithAllIn: associatedAccounts.
	
	self assert: compositeAccount hasTheSameTransactionsAs: associatedAccounts! !

!CompositeAccountTest methodsFor: 'tests - transactions' stamp: 'IB 5/22/2023 01:36:29'!
testCompositeAccountTrasactionsAreTheSameAsTheOnlySimpleAccountAssociatedToIt

	| associatedAccount compositeAccount | 
	
	associatedAccount := {self simpleAccountWithTransactions}.
	compositeAccount := self compositeAccountAssociatedWithAllIn: associatedAccount.
	
	self assert: compositeAccount hasTheSameTransactionsAs: associatedAccount ! !


!CompositeAccountTest methodsFor: 'tests' stamp: 'IB 5/22/2023 00:46:10'!
testCanAddAnAccountToAnAlreadyCreatedCompositeAccount

	| simpleAccount compositeAccount |
	
	compositeAccount := self compositeAccount.
	simpleAccount := self emptySimpleAccount.
	
	compositeAccount associateWith: simpleAccount.
	
	self assert: compositeAccount associatedAccounts includes: simpleAccount! !

!CompositeAccountTest methodsFor: 'tests' stamp: 'IB 5/22/2023 01:50:14'!
testCantAddAnAccountToAnAlreadyCreatedCompositeAccountWhenItIsAlreadyAssociatedToIt

	| simpleAccount compositeAccount |
	
	simpleAccount := self emptySimpleAccount.
	compositeAccount := self compositeAccountAssociatedWithAllIn: {simpleAccount}.
	
	self shouldFailBecauseOfAssociationsWhenCreatingCompositeAccountWith: [compositeAccount associateWith: simpleAccount]! !

!CompositeAccountTest methodsFor: 'tests' stamp: 'IB 5/22/2023 00:19:51'!
testCantCreateCompositeAccountWithTheSameCompositeAccountTwice

	|compositeAccount |
	
	compositeAccount := self compositeAccount.

	self shouldFailBecauseOfAssociationsWhenCreatingCompositeAccountWith: [CompositeAccount associatedWithAllIn: {compositeAccount. compositeAccount}] 
	! !

!CompositeAccountTest methodsFor: 'tests' stamp: 'IB 5/22/2023 00:20:01'!
testCantCreateCompositeAccountWithTheSameSimpleAccountTwice

	|simpleAccount |
	
	simpleAccount := self emptySimpleAccount.

	self shouldFailBecauseOfAssociationsWhenCreatingCompositeAccountWith: [CompositeAccount associatedWithAllIn: {simpleAccount. simpleAccount}] 

	! !

!CompositeAccountTest methodsFor: 'tests' stamp: 'IB 5/22/2023 00:20:17'!
testCantCreateCompositeAccountWithTwoCompositeAccountsThatHaveTheSameSimpleAccountAssociated

	|simpleAccount compositeAccount anotherCompositeAccountWithTheSameSimpleAccounts |
	
	simpleAccount := self emptySimpleAccount.
	compositeAccount := self compositeAccountAssociatedWithAllIn: {simpleAccount}.
	anotherCompositeAccountWithTheSameSimpleAccounts := self compositeAccountAssociatedWithAllIn: {simpleAccount}.
	
	self shouldFailBecauseOfAssociationsWhenCreatingCompositeAccountWith: 
		[CompositeAccount associatedWithAllIn: {compositeAccount. anotherCompositeAccountWithTheSameSimpleAccounts}] 

	! !

!CompositeAccountTest methodsFor: 'tests' stamp: 'IB 5/22/2023 00:50:59'!
testCreationFailsWhenTryingToCreateWithoutAssociatedAccounts

	self should: [CompositeAccount associatedWithAllIn: #()] 
		raise: Error - MessageNotUnderstood 
		withMessageText: CompositeAccount emptyCompositeAccountErrorExplanation ! !

!CompositeAccountTest methodsFor: 'tests' stamp: 'IB 5/22/2023 00:31:31'!
testCreationFailsWhenWhenTryingToAssociateTwoCompositeAccountsWhenOneHasTheSameAccountThatTheOtherOneButInADifferentLevel

	|simpleAccount compositeAccount anotherCompositeAccount compositeAccountWithTheSameSimpleAccountThatTheFirstOne |
	
	simpleAccount := self emptySimpleAccount.
	compositeAccount := self compositeAccountAssociatedWithAllIn: {simpleAccount}.
	compositeAccountWithTheSameSimpleAccountThatTheFirstOne := self compositeAccountAssociatedWithAllIn: {simpleAccount}.
	anotherCompositeAccount := self compositeAccountAssociatedWithAllIn: {compositeAccountWithTheSameSimpleAccountThatTheFirstOne}.
	
	self shouldFailBecauseOfAssociationsWhenCreatingCompositeAccountWith: 
		[CompositeAccount associatedWithAllIn: {compositeAccount. anotherCompositeAccount}] 

	! !


!classDefinition: #SimpleAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #SimpleAccountTest
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SimpleAccountTest methodsFor: 'support - asserting' stamp: 'IB 5/21/2023 20:24:48'!
assertAccountBalanceEqualsTo: aBalance
		
	 self assert: aBalance equals: account balance
! !


!SimpleAccountTest methodsFor: 'running' stamp: 'IB 5/21/2023 19:49:26'!
setUp

	account := SimpleAccount new
! !


!SimpleAccountTest methodsFor: 'support - transactions' stamp: 'IB 5/21/2023 20:17:21'!
depositFor: anAmountToBeDepositedInTheAccount

	^Deposit for: anAmountToBeDepositedInTheAccount! !

!SimpleAccountTest methodsFor: 'support - transactions' stamp: 'IB 5/21/2023 20:21:15'!
withdrawalFor: anAmountToBeWithdrawnFromAnAccount

	^Withdrawal for: anAmountToBeWithdrawnFromAnAccount! !


!SimpleAccountTest methodsFor: 'support - account' stamp: 'IB 5/21/2023 21:20:10'!
onAccountMakeADepositOf: anAmountToBeDepositedInTheAccount

	 ^self onAccountRegister: (self depositFor: anAmountToBeDepositedInTheAccount)! !

!SimpleAccountTest methodsFor: 'support - account' stamp: 'IB 5/21/2023 21:21:04'!
onAccountMakeAWithdrawalOf: anAmountToBeWithdrawnFromAnAccount

	 ^self onAccountRegister: (self withdrawalFor: anAmountToBeWithdrawnFromAnAccount)! !

!SimpleAccountTest methodsFor: 'support - account' stamp: 'IB 5/21/2023 21:21:11'!
onAccountRegister: anAccountTransaction

	^account register: anAccountTransaction ! !


!SimpleAccountTest methodsFor: 'tests' stamp: 'IB 5/21/2023 20:23:57'!
test01AccountBalanceIsNothingWhenCreated 

	self assertAccountBalanceEqualsTo: 0
! !

!SimpleAccountTest methodsFor: 'tests' stamp: 'IB 5/21/2023 20:24:02'!
test02DepositIncreasesAccountBalance 
	
	self onAccountMakeADepositOf: 100.
		
	self assertAccountBalanceEqualsTo: 100
! !

!SimpleAccountTest methodsFor: 'tests' stamp: 'IB 5/21/2023 20:24:06'!
test03WithdrawalDecreasesAccountBalance 

	self onAccountMakeADepositOf: 100.
	
	self onAccountMakeAWithdrawalOf: 50.
		
	self assertAccountBalanceEqualsTo: 50
! !

!SimpleAccountTest methodsFor: 'tests' stamp: 'IB 5/22/2023 16:40:31'!
test04WithdrawalValueIsPositive
	
	self assert: 50 equals: (self withdrawalFor: 50) amount
! !

!SimpleAccountTest methodsFor: 'tests' stamp: 'IB 5/21/2023 20:14:25'!
test05AccountKnowsRegisteredTransactions 

	| deposit withdraw |
	
	deposit := self onAccountMakeADepositOf: 100.
	withdraw := self onAccountMakeAWithdrawalOf: 50.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw)
! !

!SimpleAccountTest methodsFor: 'tests' stamp: 'IB 5/21/2023 20:18:21'!
test06AccountDoNotKnowUnregisteredTransactions

	self deny: (account hasRegistered: (self depositFor: 200)).
	self deny: (account hasRegistered: (self withdrawalFor: 50)).
! !

!SimpleAccountTest methodsFor: 'tests' stamp: 'IB 5/21/2023 20:18:40'!
test07AccountKnowsItsTransactions 

	| deposit |
	
	deposit := self onAccountMakeADepositOf: 50.
		
	self assert: account transactions size equals: 1.
	self assert: account transactions includes: deposit! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'balance' stamp: 'IB 5/21/2023 22:03:22'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'IB 5/21/2023 22:04:02'!
transactions

	self subclassResponsibility ! !


!classDefinition: #CompositeAccount category: 'Portfolio-Ejercicio'!
Account subclass: #CompositeAccount
	instanceVariableNames: 'associatedAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!CompositeAccount methodsFor: 'initialization' stamp: 'IB 5/22/2023 01:05:11'!
associateWith: anAccountToBeAssociatedToTheCompositeAccount

	self become: 
		(CompositeAccount associatedWithAllIn: 
			(associatedAccounts asOrderedCollection add: anAccountToBeAssociatedToTheCompositeAccount; yourself))! !

!CompositeAccount methodsFor: 'initialization' stamp: 'IB 5/22/2023 00:50:13'!
initializeAssociatedWithAllIn: aCollectionOfAccounts

	associatedAccounts := aCollectionOfAccounts! !


!CompositeAccount methodsFor: 'accessing' stamp: 'IB 5/22/2023 00:47:18'!
associatedAccounts
	
	^associatedAccounts! !

!CompositeAccount methodsFor: 'accessing' stamp: 'IB 5/22/2023 00:48:36'!
associatedSimpleAccounts

	^(self associatedAccounts collect: #associatedSimpleAccounts) flatten! !


!CompositeAccount methodsFor: 'testing' stamp: 'IB 5/21/2023 22:19:27'!
hasRegistered: anAccountTransaction

	^associatedAccounts anySatisfy: [:simpleAccount | simpleAccount hasRegistered: anAccountTransaction]! !


!CompositeAccount methodsFor: 'transactions' stamp: 'IB 5/22/2023 00:47:36'!
transactions
	
	^(self associatedAccounts collect: #transactions) flatten asOrderedCollection! !


!CompositeAccount methodsFor: 'balance' stamp: 'IB 5/22/2023 00:47:47'!
balance
	
	^self associatedAccounts sum: #balance! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompositeAccount class' category: 'Portfolio-Ejercicio'!
CompositeAccount class
	instanceVariableNames: ''!

!CompositeAccount class methodsFor: 'accessing' stamp: 'IB 5/22/2023 00:50:59'!
emptyCompositeAccountErrorExplanation
	
	^'A composite account has to have at least one simple account associated to it.'! !

!CompositeAccount class methodsFor: 'accessing' stamp: 'IB 5/21/2023 23:22:13'!
sameAccountAssociatedMoreThanOnceErrorExplanation
	
	^'Cant have the same account associated more than one time'! !


!CompositeAccount class methodsFor: 'instance creation' stamp: 'IB 5/22/2023 00:08:43'!
associatedWithAllIn: aCollectionOfAccounts 
	
	self assertNotEmpty: aCollectionOfAccounts.
	self assertNoRepeatedAccountsIn: aCollectionOfAccounts.
	
	^self new initializeAssociatedWithAllIn: aCollectionOfAccounts ! !


!CompositeAccount class methodsFor: 'asserting' stamp: 'IB 5/22/2023 01:01:58'!
assertNoRepeatedAccountsIn: aCollectionOfAccounts

	| simpleAccounts |
	
	simpleAccounts := self simpleAccountsIn: aCollectionOfAccounts.
	
	simpleAccounts asSet size = simpleAccounts size 
		ifFalse: [Error signal: self sameAccountAssociatedMoreThanOnceErrorExplanation]! !

!CompositeAccount class methodsFor: 'asserting' stamp: 'IB 5/22/2023 00:50:59'!
assertNotEmpty: aCollectionOfAccounts

	aCollectionOfAccounts 
		ifEmpty: [Error signal: self emptyCompositeAccountErrorExplanation]! !

!CompositeAccount class methodsFor: 'asserting' stamp: 'IB 5/22/2023 01:02:31'!
simpleAccountsIn: aCollectionOfAccounts

	^ (aCollectionOfAccounts collect: #associatedSimpleAccounts) flatten! !


!classDefinition: #SimpleAccount category: 'Portfolio-Ejercicio'!
Account subclass: #SimpleAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SimpleAccount methodsFor: 'initialization' stamp: 'IB 5/21/2023 20:08:24'!
initialize

	transactions := OrderedCollection new! !


!SimpleAccount methodsFor: 'accessing' stamp: 'IB 5/22/2023 00:44:46'!
associatedSimpleAccounts

	^{self}! !


!SimpleAccount methodsFor: 'transactions' stamp: 'IB 5/21/2023 21:17:00'!
register: aTransaction

	^transactions add: aTransaction 
! !

!SimpleAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!SimpleAccount methodsFor: 'balance' stamp: 'IB 5/22/2023 01:08:11'!
balance

	^ transactions sum: #amountAsSeenFromParty ifEmpty: [ 0 ]! !


!SimpleAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'IB 5/21/2023 19:29:22'!
amount

	^amount! !

!AccountTransaction methodsFor: 'value' stamp: 'IB 5/21/2023 19:33:27'!
amountAsSeenFromParty

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'IB 5/21/2023 19:30:37'!
initializeFor: aValue

	amount := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'IB 5/21/2023 21:15:59'!
for: aValue

	^self new initializeFor: aValue! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'IB 5/21/2023 19:29:55'!
amountAsSeenFromParty

	^ self amount! !


!classDefinition: #Withdrawal category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdrawal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdrawal methodsFor: 'value' stamp: 'IB 5/21/2023 19:30:13'!
amountAsSeenFromParty

	^ self amount negated! !
