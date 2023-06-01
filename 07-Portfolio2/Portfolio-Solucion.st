!classDefinition: #AssociatedAccountsReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #AssociatedAccountsReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AssociatedAccountsReportTest methodsFor: 'support' stamp: 'IB 6/1/2023 15:56:55'!
familyReceptiveAccount

	^ ReceptiveAccount named: self familyReceptiveAccountName! !

!AssociatedAccountsReportTest methodsFor: 'support' stamp: 'IB 6/1/2023 15:56:55'!
familyReceptiveAccountName

	^ 'Cuenta familiar'! !

!AssociatedAccountsReportTest methodsFor: 'support' stamp: 'IB 6/1/2023 15:57:08'!
personalReceptiveAccount

	^ ReceptiveAccount named: self personalReceptiveAccountName! !

!AssociatedAccountsReportTest methodsFor: 'support' stamp: 'IB 6/1/2023 15:57:08'!
personalReceptiveAccountName

	^ 'Cuenta personal'! !

!AssociatedAccountsReportTest methodsFor: 'support' stamp: 'IB 6/1/2023 15:56:30'!
principalPortfolioName

	^ 'Portfolio Principal'! !

!AssociatedAccountsReportTest methodsFor: 'support' stamp: 'IB 6/1/2023 16:38:46'!
secondaryPortfolioName

	^ 'Portfolio secundario'! !


!AssociatedAccountsReportTest methodsFor: 'tests' stamp: 'IB 6/1/2023 15:56:30'!
test01PortfolioCanGenerateReportWhenNoReceptiveAccountsAssociated

	self 
		assert: ((Portfolio named: self principalPortfolioName) generateReportOfType: AssociatedAccountsReport new) 
		equals: self principalPortfolioName
! !

!AssociatedAccountsReportTest methodsFor: 'tests' stamp: 'IB 6/1/2023 15:57:35'!
test02ReceptiveAccountCantGenerateReport

	self 
		should: [self familyReceptiveAccount generateReportOfType: AssociatedAccountsReport new]
		raise: Error
		withMessageText: 'This message is not appropriate for this object'
! !

!AssociatedAccountsReportTest methodsFor: 'tests' stamp: 'IB 6/1/2023 15:57:51'!
test03PortfolioCanGenerateReportWhenOneReceptiveAccountAssociated

	|portfolio|
	portfolio := Portfolio named: self principalPortfolioName with: self familyReceptiveAccount.
	
	self 
		assert: ( portfolio generateReportOfType: AssociatedAccountsReport new)
		equals: self principalPortfolioName, Character newLineCharacter asString, Character tab asString, self familyReceptiveAccountName
! !

!AssociatedAccountsReportTest methodsFor: 'tests' stamp: 'IB 6/1/2023 16:09:24'!
test04PortfolioCanGenerateReportWhenMoreThanOneReceptiveAccountAssociated

	|portfolio|
	portfolio := 
		Portfolio 
			named: self principalPortfolioName 
			with: self familyReceptiveAccount 
			with: self personalReceptiveAccount.
	
	self 
		assert: (portfolio generateReportOfType: AssociatedAccountsReport new)
		equals: 
			self principalPortfolioName, Character newLineCharacter asString,  
				Character tab asString, self familyReceptiveAccountName, Character newLineCharacter asString, 
				Character tab asString, self personalReceptiveAccountName
! !

!AssociatedAccountsReportTest methodsFor: 'tests' stamp: 'IB 6/1/2023 16:38:46'!
test05PortfolioCanGenerateReportWhenOnePortfolioWithReceptiveAccountAssociated

	|portfolio|
	portfolio := 
		Portfolio 
			named: self principalPortfolioName 
			with: (Portfolio named: self secondaryPortfolioName with: self familyReceptiveAccount).
	
	self 
		assert: (portfolio generateReportOfType: AssociatedAccountsReport new)
		equals: 
			self principalPortfolioName, Character newLineCharacter asString,  
				Character tab asString, self secondaryPortfolioName, Character newLineCharacter asString, 
				Character tab asString, Character tab asString, self familyReceptiveAccountName
! !

!AssociatedAccountsReportTest methodsFor: 'tests' stamp: 'IB 6/1/2023 16:41:53'!
test06PortfolioCanGenerateReportWithPortfolioAndReceptiveAccountAssociated

	|portfolio|
	portfolio := 
		Portfolio 
			named: self principalPortfolioName 
			with: self personalReceptiveAccount with: (Portfolio named: self secondaryPortfolioName with: self familyReceptiveAccount).
	
	self 
		assert: (portfolio generateReportOfType: AssociatedAccountsReport new)
		equals: 
			self principalPortfolioName, Character newLineCharacter asString,  
				Character tab asString, self personalReceptiveAccountName, Character newLineCharacter asString, 
				Character tab asString, self secondaryPortfolioName, Character newLineCharacter asString, 
					Character tab asString, Character tab asString, self familyReceptiveAccountName
! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IB 5/31/2023 19:05:35'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IB 5/28/2023 20:48:12'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IB 5/28/2023 20:57:06'!
test08CanTransferWhenHavingFunds

	| accountFrom accountTo |
	
	accountFrom := ReceptiveAccount new.
	accountTo := ReceptiveAccount new.
	Deposit register: 100 on: accountFrom.
	
	Transfer send: 100 from: accountFrom to: accountTo.
	
	self assert: accountFrom balance equals: 0.
	self assert: accountTo balance equals: 100
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'IB 5/31/2023 19:03:19'!
test09CanTransferWhenThereIsNotEnoughFunds

	| accountFrom accountTo |
	
	accountFrom := ReceptiveAccount new.
	accountTo := ReceptiveAccount new.
	
	Transfer send: 100 from: accountFrom to: accountTo.
	
	self assert: accountFrom balance equals: -100.
	self assert: accountTo balance equals: 100
	
! !


!classDefinition: #SummaryReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #SummaryReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 19:35:37'!
test01CanReceptiveAccountGenerateSummaryReportWhenNoTransactionsRegistered

	| account  |
	
	account := ReceptiveAccount new.
	
	self assert: (account generateReportOfType: SummaryReport new) equals: 'Balance = 0'
	
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 19:35:04'!
test02CanReceptiveAccountGenerateSummaryReportWhenOneDepositRegistered

	| account  |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self assert: (account generateReportOfType: SummaryReport new) equals: 
		'Depósito por 100.' ,Character newLineCharacter asString, 'Balance = 100'! !

!SummaryReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 19:39:29'!
test03CanReceptiveAccountGenerateSummaryReportWhenOneWithdrawRegistered

	| account  |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	self assert: (account generateReportOfType: SummaryReport new) equals: 
		'Extracción por 100.' ,Character newLineCharacter asString, 'Balance = -100'! !

!SummaryReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 19:46:57'!
test04CanReceptiveAccountGenerateSummaryReportWhenOneOriginTransferRegistered

	| account  anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer send: 100 from: account to: anotherAccount.
	
	self assert: (account generateReportOfType: SummaryReport new) equals: 
		'Salida por transferencia de 100.' ,Character newLineCharacter asString, 'Balance = -100'.
		
	self assert: (anotherAccount generateReportOfType: SummaryReport new) equals: 
		'Entrada por transferencia de 100.' ,Character newLineCharacter asString, 'Balance = 100'.! !

!SummaryReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 19:56:17'!
test05CanReceptiveAccountGenerateSummaryReportWhenMoreThanOneTransactionRegistered

	| account  |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 100 on: account.
	
	self assert: (account generateReportOfType: SummaryReport new) equals: 
		'Depósito por 100.' ,Character newLineCharacter asString,
		'Extracción por 100.' ,Character newLineCharacter asString, 
		'Balance = 0'! !

!SummaryReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 20:07:54'!
test06CanPortfolioGenerateSummaryReportWhenAssociatedToNoReceptiveAccount
	
	self assert: (Portfolio new generateReportOfType: SummaryReport new) equals: 'Balance = 0'
	
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 20:08:04'!
test07CanPortfolioGenerateSummaryReportWhenAssociatedToOnlyOneReceptiveAccount

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio with: account.
	
	self assert: (portfolio generateReportOfType: SummaryReport new) equals: 
		'Depósito por 100.' ,Character newLineCharacter asString, 'Balance = 100'
	
! !

!SummaryReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 20:10:34'!
test08CanPortfolioGenerateSummaryReportWhenAssociatedToMoreThanOneReceptiveAccount

	| account anotherAccount portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anotherAccount.
	
	portfolio := Portfolio with: account with: anotherAccount.
	
	self assert: (portfolio generateReportOfType: SummaryReport new) equals: 
		'Depósito por 100.' ,Character newLineCharacter asString,
		'Extracción por 100.' ,Character newLineCharacter asString, 
		'Balance = 0'
! !


!classDefinition: #TransferNetReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:08:38'!
test01CanReceptiveAccountGenerateReportWhenNoTransactionsRegistered

	self assert: (ReceptiveAccount new generateReportOfType: TransferNetReport new) equals: 0
	
! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:10:40'!
test02CanReceptiveAccountGenerateReportWhenOneDepositRegistered

	| account  |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self assert: (account generateReportOfType: TransferNetReport new) equals: 0! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:11:20'!
test03CanReceptiveAccountGenerateReportWhenOneWithdrawRegistered

	| account  |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	self assert: (account generateReportOfType: TransferNetReport new) equals: 0! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:16:46'!
test04CanReceptiveAccountGenerateReportWhenOneTransferRegistered

	| account  anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer send: 100 from: account to: anotherAccount.
	
	self assert: (account generateReportOfType: TransferNetReport new) equals: -100.
		
	self assert: (anotherAccount generateReportOfType: TransferNetReport new) equals: 100.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:21:47'!
test05CanReceptiveAccountGenerateReportWhenMoreThanOneTransferRegistered

	| account  anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer send: 100 from: account to: anotherAccount.
	Transfer send: 50 from: account to: anotherAccount.
	
	self assert: (account generateReportOfType: TransferNetReport new) equals: -150.
		
	self assert: (anotherAccount generateReportOfType: TransferNetReport new) equals: 150.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:24:56'!
test06CanReceptiveAccountGenerateReportWhenOneTransferAndAnotherTransactionRegistered

	| account  anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 50 on: account.
	Transfer send: 100 from: account to: anotherAccount.
	
	self assert: (account generateReportOfType: TransferNetReport new) equals: -100.
		
	self assert: (anotherAccount generateReportOfType: TransferNetReport new) equals: 100! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:26:51'!
test07CanPortfolioGenerateReportWhenAssociatedToNoReceptiveAccount
	
	self assert: (Portfolio new generateReportOfType: TransferNetReport new) equals: 0! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:35:37'!
test08CanPortfolioGenerateReportWhenAssociatedToOnlyOneReceptiveAccountWithOneTransfer

	| account portfolio anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer send: 100 from: account to: anotherAccount.
	
	portfolio := Portfolio with: account.
	
	self assert: (portfolio generateReportOfType: TransferNetReport new) equals: -100
	! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'IB 5/31/2023 21:38:23'!
test09CanPortfolioGenerateReportWhenAssociatedToMoreThanOneReceptiveAccountTransfers

	| account portfolio anotherAccount|
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer send: 100 from: account to: anotherAccount.
	
	portfolio := Portfolio with: account with: anotherAccount.
	
	self assert: (portfolio generateReportOfType: TransferNetReport new) equals: 0
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'IB 6/1/2023 15:39:23'!
name

	^name! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'IB 6/1/2023 15:38:17'!
initializeNamed: aPortfolioName 

	self initialize.
	name := aPortfolioName! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'IB 6/1/2023 15:38:52'!
named: aName

	^self new initializeNamed: aName ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'IB 5/31/2023 20:21:43'!
accounts
	
	^accounts copy! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'printing' stamp: 'IB 5/31/2023 20:19:16'!
generateReportOfType: aReport

	^aReport generateEntriesForPortfolio: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'IB 6/1/2023 15:46:59'!
named: aString with: aReceptiveAccount

	^(self named: aString) 
		add: aReceptiveAccount; 
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'IB 6/1/2023 15:58:51'!
named: aString with: aReceptiveAccount with: anotherReceptiveAccount

	^(self named: aString) 
		add: aReceptiveAccount; 
		add: anotherReceptiveAccount; 
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'printing' stamp: 'IB 5/31/2023 19:26:03'!
generateReportOfType: aReport

	^aReport generateEntriesFor: transactions on: self! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 21:19:52'!
generateEntryForDeposit: aDeposit

	self subclassResponsibility ! !

!AccountReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 21:20:33'!
generateEntryForDestinationTransfer: aDestinationTransfer

	self subclassResponsibility ! !

!AccountReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 21:20:45'!
generateEntryForOriginTransfer: anOriginTransfer

	self subclassResponsibility ! !

!AccountReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 21:20:20'!
generateEntryForWithdraw: aWithdraw

	self subclassResponsibility ! !


!AccountReport methodsFor: 'evaluating' stamp: 'IB 5/31/2023 21:18:23'!
generateEntriesFor: aTransactionsCollection on: aReceptiveAccount

	self subclassResponsibility ! !

!AccountReport methodsFor: 'evaluating' stamp: 'IB 5/31/2023 21:18:47'!
generateEntriesForPortfolio: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #AssociatedAccountsReport category: 'Portfolio-Solucion'!
AccountReport subclass: #AssociatedAccountsReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AssociatedAccountsReport methodsFor: 'evaluating' stamp: 'IB 6/1/2023 15:43:17'!
generateEntriesFor: aTransactionsCollection on: aReceptiveAccount

	self shouldNotImplement! !

!AssociatedAccountsReport methodsFor: 'evaluating' stamp: 'IB 6/1/2023 16:44:51'!
generateEntriesForPortfolio: aPortfolio
	
	^String streamContents: [:aStream | self generateNecesaryEntriesFor: aPortfolio ofLevel: 0 on: aStream]! !


!AssociatedAccountsReport methodsFor: 'support' stamp: 'IB 6/1/2023 16:11:20'!
addNameOf: anAccount to: aStream

	^ aStream nextPutAll: anAccount name! !

!AssociatedAccountsReport methodsFor: 'support' stamp: 'IB 6/1/2023 16:25:17'!
addNewEntryOfLevel: aTreeLevel to: aStream

	aStream nextPut: Character newLineCharacter.
	aTreeLevel timesRepeat: [aStream nextPut: Character tab]! !

!AssociatedAccountsReport methodsFor: 'support' stamp: 'IB 6/1/2023 16:45:00'!
generateNecesaryEntriesFor: anAccount ofLevel: currentTreeLevel on: aResponseStream

	self addNameOf: anAccount to: aResponseStream.
	(anAccount isKindOf: ReceptiveAccount) ifTrue: [^self]. 
	
	anAccount accounts do: [:account |
		self addNewEntryOfLevel: (currentTreeLevel + 1) to: aResponseStream.
		self generateNecesaryEntriesFor: account ofLevel: (currentTreeLevel + 1) on: aResponseStream]! !


!classDefinition: #SummaryReport category: 'Portfolio-Solucion'!
AccountReport subclass: #SummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'evaluating' stamp: 'IB 5/31/2023 21:18:10'!
generateEntriesFor: aTransactionsCollection on: aReceptiveAccount

	|reportEntries|
	
	reportEntries := self reportEntriesForEachTransactionIn: aTransactionsCollection.
	^ self finalizeReportFor: aReceptiveAccount withAllEntriesIn: reportEntries! !

!SummaryReport methodsFor: 'evaluating' stamp: 'IB 5/31/2023 21:05:38'!
generateEntriesForPortfolio: aPortfolio

	| reportEntries |
	
	reportEntries := self reportEntriesOfAllReceptiveAccountsAssociatedTo: aPortfolio.
	^ self finalizeReportFor: aPortfolio withAllEntriesIn: reportEntries! !


!SummaryReport methodsFor: 'support' stamp: 'IB 5/31/2023 20:47:49'!
addLastLineWithBalanceOf: aPortfolio to: anUnfinishedReport

	^ anUnfinishedReport add: ('Balance = ', aPortfolio balance asString)! !

!SummaryReport methodsFor: 'support' stamp: 'IB 5/31/2023 20:52:35'!
finalReportWithAllEntriesIn: entriesForEachTransaction

	^ entriesForEachTransaction fold: [:previousEntry :currentEntry | previousEntry , Character newLineCharacter asString, currentEntry]! !

!SummaryReport methodsFor: 'support' stamp: 'IB 5/31/2023 21:01:55'!
finalizeReportFor: aPortfolio withAllEntriesIn: reportEntries
	
	self addLastLineWithBalanceOf: aPortfolio to: reportEntries.
	^self finalReportWithAllEntriesIn: reportEntries! !

!SummaryReport methodsFor: 'support' stamp: 'IB 5/31/2023 20:55:27'!
removeLastLineOfReport: report

	^ report allButLast: (report size - (report findString: 'Balance') + 2)! !

!SummaryReport methodsFor: 'support' stamp: 'IB 5/31/2023 20:50:28'!
reportEntriesForEachTransactionIn: aTransactions

	^ (aTransactions collect: [:transaction | transaction generateEntryForReport: self]) asOrderedCollection! !

!SummaryReport methodsFor: 'support' stamp: 'IB 5/31/2023 21:04:57'!
reportEntriesOfAllReceptiveAccountsAssociatedTo: aPortfolio

	^ (aPortfolio accounts collect: [:receptiveAccount | self removeLastLineOfReport: (receptiveAccount generateReportOfType: self)]) flatten asOrderedCollection! !


!SummaryReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 19:59:57'!
entryWithDescription: transactionDescription andValue: transactionValue

	^ transactionDescription, transactionValue asString, '.'! !

!SummaryReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 20:01:15'!
generateEntryForDeposit: aDeposit

	^self entryWithDescription: 'Depósito por ' andValue: aDeposit value! !

!SummaryReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 20:00:58'!
generateEntryForDestinationTransfer: aDestinationTransfer 

	^self entryWithDescription: 'Entrada por transferencia de ' andValue: aDestinationTransfer value! !

!SummaryReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 20:00:38'!
generateEntryForOriginTransfer: anOriginTransfer 
	
	^self entryWithDescription: 'Salida por transferencia de ' andValue: anOriginTransfer value! !

!SummaryReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 20:00:19'!
generateEntryForWithdraw: aWithdraw

	^self entryWithDescription: 'Extracción por ' andValue: aWithdraw value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryReport class' category: 'Portfolio-Solucion'!
SummaryReport class
	instanceVariableNames: ''!

!SummaryReport class methodsFor: 'as yet unclassified' stamp: 'IB 5/31/2023 19:19:57'!
generateEntriesFor: aTransactions 
	self shouldBeImplemented.! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
AccountReport subclass: #TransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 21:14:32'!
generateEntryForDeposit: aDeposit
	
	^0! !

!TransferNetReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 21:17:02'!
generateEntryForDestinationTransfer: aDestinationTransfer

	^aDestinationTransfer value! !

!TransferNetReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 21:16:27'!
generateEntryForOriginTransfer: anOriginTransfer

	^anOriginTransfer value negated! !

!TransferNetReport methodsFor: 'evaluating - entries' stamp: 'IB 5/31/2023 21:14:48'!
generateEntryForWithdraw: aWithdraw 
	
	^0! !


!TransferNetReport methodsFor: 'evaluating' stamp: 'IB 5/31/2023 21:23:42'!
generateEntriesFor: aTransactionsCollection on: aReceptiveAccount

	^ aTransactionsCollection 
		inject: 0
		into: [ :currentValueReport :transaction |  currentValueReport + (transaction generateEntryForReport: self) ]! !

!TransferNetReport methodsFor: 'evaluating' stamp: 'IB 5/31/2023 21:38:02'!
generateEntriesForPortfolio: aPortfolio

	^ aPortfolio accounts 
		inject: 0 
		into: [:previousAccountReportValue :receptiveAccount | 
			previousAccountReportValue + (receptiveAccount generateReportOfType: self)]! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'printing' stamp: 'IB 5/31/2023 19:37:52'!
generateEntryForReport: aReport

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'balance' stamp: 'IB 5/28/2023 21:26:20'!
affectBalance: aBalance

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'printing' stamp: 'IB 5/31/2023 19:38:06'!
generateEntryForReport: aReport

	^aReport generateEntryForDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Transfer
	instanceVariableNames: 'value originTransferTransaction destinationTransferTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'IB 5/31/2023 19:01:17'!
initializeFor: aValue  

	value := aValue.
	originTransferTransaction := OriginTransfer relatedTo: self.
	destinationTransferTransaction  := DestinationTransfer relatedTo: self
	! !


!Transfer methodsFor: 'accessing' stamp: 'IB 5/31/2023 18:53:40'!
destinationTransaction
	
	^destinationTransferTransaction! !

!Transfer methodsFor: 'accessing' stamp: 'IB 5/31/2023 18:53:11'!
originTransaction
	
	^originTransferTransaction! !

!Transfer methodsFor: 'accessing' stamp: 'IB 5/31/2023 18:59:28'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'IB 5/31/2023 19:01:40'!
for: aValue  

	^self new initializeFor: aValue! !

!Transfer class methodsFor: 'instance creation' stamp: 'IB 5/31/2023 19:01:45'!
send: aValue from: aReceptiveAccount to: anotherReceptiveAccount

	| transaction |
	transaction := self for: aValue.
	
	aReceptiveAccount register: transaction originTransaction.
	anotherReceptiveAccount register: transaction destinationTransaction.
	
	^transaction! !


!classDefinition: #DestinationTransfer category: 'Portfolio-Solucion'!
Transfer subclass: #DestinationTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DestinationTransfer methodsFor: 'initialization' stamp: 'IB 5/31/2023 18:57:19'!
initializeRelatedTo: aTransfer

	transfer := aTransfer! !


!DestinationTransfer methodsFor: 'balance' stamp: 'IB 5/31/2023 18:59:52'!
affectBalance: currentBalance 
	
	^currentBalance + transfer value! !


!DestinationTransfer methodsFor: 'printing' stamp: 'IB 5/31/2023 19:51:31'!
generateEntryForReport: aReport

	^aReport generateEntryForDestinationTransfer: self! !


!DestinationTransfer methodsFor: 'accessing' stamp: 'IB 5/31/2023 19:57:36'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DestinationTransfer class' category: 'Portfolio-Solucion'!
DestinationTransfer class
	instanceVariableNames: ''!

!DestinationTransfer class methodsFor: 'instance creation' stamp: 'IB 5/31/2023 18:57:10'!
relatedTo: aTransfer 

	^self new initializeRelatedTo: aTransfer ! !


!classDefinition: #OriginTransfer category: 'Portfolio-Solucion'!
Transfer subclass: #OriginTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OriginTransfer methodsFor: 'initialization' stamp: 'IB 5/31/2023 18:56:54'!
initializeRelatedTo: aTransfer

	transfer := aTransfer! !


!OriginTransfer methodsFor: 'balance' stamp: 'IB 5/31/2023 18:58:13'!
affectBalance: currentBalance

	^currentBalance - transfer value! !


!OriginTransfer methodsFor: 'printing' stamp: 'IB 5/31/2023 19:47:34'!
generateEntryForReport: aReport

	^aReport generateEntryForOriginTransfer: self! !


!OriginTransfer methodsFor: 'accessing' stamp: 'IB 5/31/2023 19:57:43'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OriginTransfer class' category: 'Portfolio-Solucion'!
OriginTransfer class
	instanceVariableNames: ''!

!OriginTransfer class methodsFor: 'instance creation' stamp: 'IB 5/31/2023 18:56:38'!
relatedTo: aTransfer

	^self new initializeRelatedTo: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'printing' stamp: 'IB 5/31/2023 19:43:16'!
generateEntryForReport: aReport

	^aReport generateEntryForWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
